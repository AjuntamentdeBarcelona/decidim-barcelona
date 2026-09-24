# frozen_string_literal: true

# decidim-sortitions was removed from Decidim core in 0.32. Rows that still point at
# Decidim::Sortitions::* raise NameError wherever Rails has to resolve the missing class
# from a polymorphic association, and both of these raise before any rescue in the
# presenters or views can intervene:
#
#   /notifications  Decidim::NotificationCell#show -> can_participate? -> resource
#   /admin/logs     Decidim::Admin::LogsController#base_query -> .includes(:resource)
#
# The remaining `versions` rows are inert (only reachable from sortition pages, which are
# gone) but are deleted too so the sweep comes back clean.
#
# Everything is raw SQL on purpose: the models disappear with the gem, so ActiveRecord
# cannot be used to load or destroy these rows.
namespace :decidim_barcelona do
  namespace :upgrade do
    namespace :sortitions do
      pattern = "Decidim::Sortitions::%"

      targets = [
        {
          table: "decidim_notifications",
          condition: "decidim_resource_type LIKE :pattern OR event_class LIKE :pattern",
          note: "breaks /notifications"
        },
        {
          table: "decidim_action_logs",
          condition: "resource_type LIKE :pattern",
          note: "breaks /admin/logs"
        },
        {
          table: "versions",
          condition: "item_type LIKE :pattern",
          note: "orphaned PaperTrail trace data"
        }
      ]

      build_sql = lambda do |verb, target|
        ActiveRecord::Base.sanitize_sql_array(
          ["#{verb} FROM #{target[:table]} WHERE #{target[:condition]}", { pattern: }]
        )
      end

      count_rows = ->(target) { ActiveRecord::Base.connection.select_value(build_sql.call("SELECT count(*)", target)).to_i }

      # Counts every polymorphic *_type column in the schema, so anything not covered by
      # `targets` above still shows up instead of being silently missed.
      sweep = lambda do
        ActiveRecord::Base.connection.select_rows(<<~SQL.squish)
          SELECT * FROM (
            SELECT table_name || '.' || column_name AS location,
                   (xpath('/row/cnt/text()', query_to_xml(
                      format('SELECT count(*) AS cnt FROM %I WHERE %I LIKE ''Decidim::Sortitions::%%''',
                             table_name, column_name), false, true, '')))[1]::text::bigint AS rows
            FROM information_schema.columns
            WHERE table_schema = 'public'
              AND right(column_name, 5) = '_type'
              AND data_type IN ('character varying', 'text')
          ) t WHERE rows > 0 ORDER BY rows DESC
        SQL
      end

      report_sweep = lambda do |logger|
        rows = sweep.call

        if rows.empty?
          logger.info("[INFO] Sweep clean: no Decidim::Sortitions::* references anywhere")
        else
          logger.info("[INFO] Remaining Decidim::Sortitions::* references:")
          rows.each { |location, count| logger.info("[INFO]   #{location}: #{count}") }
        end
      end

      desc "Report rows still referencing the removed decidim-sortitions module"
      task report: :environment do
        logger = Logger.new($stdout)

        targets.each do |target|
          logger.info("[INFO] #{target[:table]}: #{count_rows.call(target)} rows (#{target[:note]})")
        end

        report_sweep.call(logger)
      end

      desc "Delete rows referencing the removed decidim-sortitions module"
      task cleanup: :environment do
        logger = Logger.new($stdout)

        ActiveRecord::Base.transaction do
          targets.each do |target|
            if count_rows.call(target).zero?
              logger.info("[SKIP] #{target[:table]}: nothing to delete")
              next
            end

            deleted = ActiveRecord::Base.connection.exec_delete(build_sql.call("DELETE", target))
            logger.info("[INFO] #{target[:table]}: deleted #{deleted} rows (#{target[:note]})")
          end
        end

        report_sweep.call(logger)
      end
    end
  end
end

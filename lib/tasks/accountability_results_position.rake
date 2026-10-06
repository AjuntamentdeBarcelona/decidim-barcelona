# frozen_string_literal: true

# rubocop:disable Rails/SkipsModelValidations
namespace :accountability do
  namespace :results do
    # Editors have been using the accountability `weight` field as a display order
    # (whole numbers: 1, 2, 3...). This task copies those values into the new
    # `position` field, once, after deploying the position feature, and resets the
    # copied weights to 1.0 so `weight` goes back to meaning only progress weighting.
    #
    # Fractional weights are the relative weights used by the weighted progress
    # calculation (PAM 2016-2019 import) and are never copied nor modified.
    #
    #   bin/rails accountability:results:copy_weight_to_position               # dry run, only reports
    #   bin/rails accountability:results:copy_weight_to_position APPLY=1       # writes positions, resets weights
    #   bin/rails accountability:results:copy_weight_to_position COMPONENT=7181 APPLY=1
    desc "Copy whole-number weights into the results position field and reset them to 1.0 (dry run unless APPLY=1)"
    task copy_weight_to_position: :environment do
      results = Decidim::Accountability::Result
                .where(position: nil)
                .where.not(weight: nil)
                .where("weight = floor(weight) AND weight >= 1")
      results = results.where(decidim_component_id: ENV.fetch("COMPONENT")) if ENV["COMPONENT"].present?

      skipped = Decidim::Accountability::Result.where(position: nil).where("weight <> floor(weight) OR weight < 1")

      puts "Results with a whole-number weight and no position: #{results.count}"
      puts "Results with a fractional weight (left untouched): #{skipped.count}"

      results.group(:decidim_component_id).count.sort.each do |component_id, count|
        puts "  component #{component_id}: #{count}"
      end

      if ENV["APPLY"] == "1"
        updated = results.update_all("position = weight::integer, weight = 1.0")
        puts "Copied weight into position and reset weight to 1.0 for #{updated} results."
      else
        puts "Dry run. Re-run with APPLY=1 to write the positions and reset the weights."
      end
    end
  end
end
# rubocop:enable Rails/SkipsModelValidations

# frozen_string_literal: true

module Decidim
  module Stats
    class StatsJob < ApplicationJob
      queue_as :default

      def perform(minimum_count, emails, component_ids = [])
        data = Decidim::Stats::Runner.new(minimum_count: minimum_count, component_ids: component_ids).run
        csv = Decidim::Stats::CsvExporter.new(data).export

        Decidim::Stats::StatsMailer.stats(emails, csv).deliver_now
      end
    end
  end
end

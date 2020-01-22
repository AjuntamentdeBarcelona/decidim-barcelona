# frozen_string_literal: true
require "csv"

module Decidim
  module Stats
    class CsvExporter
      def initialize(data)
        @data = data
      end

      def export
        Tempfile.open(["stats", ".csv"], "#{Rails.root}/tmp/") do |tempfile|
          csv = CSV.new(tempfile)
          csv << %w(participatory_space_type participatory_space_id component_id action metric_type metric_name total)
          data.each do |line|
            csv << line.flatten
          end
          csv
        end
      end

      private

      attr_reader :data
    end
  end
end

# frozen_string_literal: true
module Decidim
  module Accountability
    class ExportResultsController < Decidim::Accountability::ApplicationController
      def csv
        send_data ResultsCSVExporter.new(current_feature).export, filename: "results.csv", disposition: "attachment"
      end

      private

      def current_feature
        @feature ||= current_participatory_process.features.find(params[:feature_id])
      end

      def current_participatory_process
        @current_participatory_process ||= ParticipatoryProcess.find_by_slug(params[:participatory_process_slug])
      end
    end
  end
end

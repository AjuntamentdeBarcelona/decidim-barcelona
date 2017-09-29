# frozen_string_literal: true
class ResultsController < DecidimController
  def export
    send_data ResultsCSVExporter.new(feature).export, filename: "results.csv", disposition: "attachment"
  end

  private

  def feature
    @feature ||= participatory_process.features.find(params[:feature_id])
  end

  def participatory_process
    @participatory_process ||= Decidim::ParticipatoryProcesses::ParticipatoryProcess.find_by_slug(params[:participatory_process_slug])
  end
end
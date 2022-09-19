# frozen_string_literal: true

class ExportResultsController < ApplicationController
  def csv
    send_data Decidim::Accountability::ResultsCSVExporter.new(current_component).export, filename: "results.csv", disposition: "attachment"
  end

  private

  def current_component
    @current_component ||= current_participatory_process.components.find(params[:component_id])
  end

  def current_participatory_process
    @current_participatory_process ||= Decidim::ParticipatoryProcess.find_by(slug: params[:participatory_process_slug])
  end
end

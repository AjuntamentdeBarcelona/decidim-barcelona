# frozen_string_literal: true

class ExportResultsController < Decidim::ApplicationController
  def csv
    enforce_permission_to(:read, :component, current_component:)

    send_data Decidim::Accountability::ResultsCsvExporter.new(current_component).export, filename: "results.csv", disposition: "attachment"
  end

  private

  def current_component
    @current_component ||= current_participatory_process.components.find(params[:component_id])
  end

  def current_participatory_process
    @current_participatory_process ||= Decidim::ParticipatoryProcess.where(organization: current_organization).find_by!(slug: params[:participatory_process_slug])
  end
end

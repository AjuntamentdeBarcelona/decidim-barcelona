# frozen_string_literal: true

module Decidim
  module Accountability
    module Admin
      # This controller allows an admin to import results from a csv file for the Accountability feature
      class ImportResultsController < Admin::ApplicationController
        def new
          @errors = []
        end

        def create
          @csv_file = params[:csv_file]
          redirect_to(new_import_path) && return if @csv_file.blank?

          i = ResultsCSVImporter.new(current_feature, @csv_file.path, current_user)
          @errors = i.import!
          if @errors.empty?
            flash[:notice] = I18n.t("imports.create.success", scope: "decidim.accountability.admin")
            redirect_to Rails.application.routes.url_helpers.import_results_path(current_participatory_process, current_feature)
          else
            flash.now[:error] = I18n.t("imports.create.invalid", scope: "decidim.accountability.admin")
            render :new
          end
        end

        private

        def current_feature
          @feature ||= current_participatory_process.features.find(params[:feature_id])
        end

        def current_participatory_process
          @current_participatory_process ||= ParticipatoryProcess.find_by(slug: params[:participatory_process_slug])
        end
      end
    end
  end
end

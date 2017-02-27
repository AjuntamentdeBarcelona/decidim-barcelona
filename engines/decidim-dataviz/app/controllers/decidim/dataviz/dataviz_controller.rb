# frozen_string_literal: true

module Decidim
  module Dataviz
    # Exposes the dataviz resource so users can view them
    class DatavizController < Decidim::Dataviz::ApplicationController
      helper Decidim::ApplicationHelper

      helper_method :available_dataviz

      def index
        redirect_to action: :show, id: available_dataviz.first
      end

      def show
        @id = params[:id]
        raise ActiveRecord::RecordNotFound unless available_dataviz.include?(@id)
      end

      private

      def available_dataviz
        %w(summary total_interactions proposals action_plans meetings map open_data)
      end
    end
  end
end

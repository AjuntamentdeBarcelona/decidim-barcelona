# frozen_string_literal: true

class StaticController < Decidim::ApplicationController
  helper_method :current_section, :sections
  before_action :check_section, only: :accountability_sections

  def accountability; end

  def accountability_sections; end

  private

  def check_section
    raise ActiveRecord::RecordNotFound unless sections.has_key?(current_section.to_sym)
  end

  def current_section
    @current_section ||= params[:section]
  end

  def sections
    @sections ||= {
      planificacio: 3,
      economia: 4,
      serveis: 1,
      etica: 4
    }
  end
end

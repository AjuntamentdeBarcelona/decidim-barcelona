class StaticController < ApplicationController
  include Decidim::LocaleSwitcher

  layout "decidim/application"

  helper_method :current_organization, :decidim_page_title

  def accountability
  end

  def accountability_sections
  end

  private

  def current_organization
    @current_organization ||= request.env["decidim.current_organization"]
  end

  def decidim_page_title
    "Accountability pages"
  end
end

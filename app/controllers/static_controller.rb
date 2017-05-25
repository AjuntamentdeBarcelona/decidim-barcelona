class StaticController < ApplicationController
  include Decidim::LocaleSwitcher
  include Decidim::NeedsOrganization

  layout "decidim/application"

  helper_method :decidim_page_title

  def accountability
  end

  def accountability_sections
  end

  private

  def decidim_page_title
    I18n.t("static.accountability.html_head_title")
  end
end

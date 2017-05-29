class StaticController < ApplicationController
  include Decidim::LocaleSwitcher
  include Decidim::NeedsOrganization
  include Decidim::MetaTagsHelper

  layout "decidim/application"

  def accountability
  end

  def accountability_sections
  end
end

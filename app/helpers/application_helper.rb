# frozen_string_literal: true
module ApplicationHelper
  include Decidim::ApplicationHelper
  include Decidim::LayoutHelper
  include Decidim::TranslationsHelper
  include Decidim::MetaTagsHelper
  include Decidim::CookiesHelper
  include Decidim::LanguageChooserHelper
  include Decidim::DecidimFormHelper
end

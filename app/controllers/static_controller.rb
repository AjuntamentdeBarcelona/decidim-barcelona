# frozen_string_literal: true

class StaticController < Decidim::ApplicationController
  skip_authorization_check

  def accountability
  end

  def accountability_sections
  end
end

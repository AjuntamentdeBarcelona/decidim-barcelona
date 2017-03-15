# frozen_string_literal: true
class DecidimController < ActionController::Base
  before_action :set_raven_context

  def set_raven_context
    return unless Rails.env.production?
    Raven.user_context({ id: session[:current_user_id] }.merge(session))
    Raven.extra_context(params: params.to_unsafe_h, url: request.url)
  end
end

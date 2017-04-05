# frozen_string_literal: true
class DecidimController < ApplicationController
  before_action :set_raven_context

  def set_raven_context
    return unless Rails.application.secrets.sentry_enabled?
    Raven.user_context({id: try(:current_user).try(:id)}.merge(session))
    Raven.extra_context(params: params.to_unsafe_h, url: request.url)
  end
end

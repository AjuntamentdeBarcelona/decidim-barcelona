# frozen_string_literal: true

class DecidimController < ApplicationController
  before_action :set_sentry_context

  def set_sentry_context
    return unless Rails.application.secrets.sentry_enabled?

    Sentry.set_user({ id: try(:current_user).try(:id) }.merge(session))
    Sentry.set_extras(params: params.to_unsafe_h, url: request.url)
  end
end

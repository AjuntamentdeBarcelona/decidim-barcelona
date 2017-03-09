# frozen_string_literal: true
class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def append_info_to_payload(payload)
    super
    payload[:remote_ip] = request.remote_ip
    payload[:user_id] = current_user.try(:id)
    payload[:organization_id] = current_organization.try(:id)
    payload[:app] = current_organization.name
    payload[:referer] = request.referer.to_s
    payload[:request_id] = request.uuid
    payload[:user_agent] = request.user_agent
    payload[:xhr] = request.xhr? ? 'true' : 'false'
  end
end

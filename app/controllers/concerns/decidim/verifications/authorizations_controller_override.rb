# frozen_string_literal: true

module Decidim
  module Verifications
    module AuthorizationsControllerOverride
      extend ActiveSupport::Concern

      included do
        skip_before_action :verify_authenticity_token, only: :renew_onboarding_data # rubocop:disable Rails/LexicallyScopedActionFilter
      end
    end
  end
end

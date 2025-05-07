# frozen_string_literal: true

module Decidim
  module System
    module SystemChecksCellOverride
      extend ActiveSupport::Concern

      included do
        private

        def correct_secret_key_base?
          Rails.application.secrets.secret_key_base&.length == 64
        end
      end
    end
  end
end

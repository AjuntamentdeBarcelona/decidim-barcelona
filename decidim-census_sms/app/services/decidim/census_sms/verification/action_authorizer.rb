# frozen_string_literal: true

module Decidim
  module CensusSms
    module Verification
      class ActionAuthorizer < Decidim::Verifications::DefaultActionAuthorizer
        BASE_OPTION_KEY = "scope_code"

        protected

        def missing_fields
          authorized_code.present? ? [] : [BASE_OPTION_KEY]
        end

        def unmatched_fields
          scope_valid? ? [] : [BASE_OPTION_KEY]
        end

        private

        def scope_valid?
          scope_codes = options.keys.map { |k| k.gsub("#{BASE_OPTION_KEY}_", "") if k.match?(BASE_OPTION_KEY) }.compact

          return unless scope_codes.any?

          authorized_code_key = "#{BASE_OPTION_KEY}_#{authorized_code}"

          authorized_code.present? && options[authorized_code_key] == "1"
        end

        def authorized_code
          authorization.metadata[BASE_OPTION_KEY]
        end
      end
    end
  end
end

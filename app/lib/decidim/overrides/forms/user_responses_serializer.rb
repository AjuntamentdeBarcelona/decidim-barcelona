# frozen_string_literal: true

module Decidim
  module Overrides
    module Forms
      module UserResponsesSerializer
        private

        def hash_for(response)
          {
            response_translated_attribute_name(:id) => response&.session_token,
            response_translated_attribute_name(:user_status) => response_translated_attribute_name(response&.decidim_user_id.present? ? "registered" : "unregistered"),
            response_translated_attribute_name(:ip_hash) => response&.ip_hash,
            response_translated_attribute_name(:created_at) => response&.created_at
          }
        end
      end
    end
  end
end

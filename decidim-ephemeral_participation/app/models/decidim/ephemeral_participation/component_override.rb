# frozen_string_literal: true

module Decidim
  module EphemeralParticipation
    module ComponentOverride
      extend ActiveSupport::Concern

      included do
        def ephemeral_participation_enabled?
          settings.try(:ephemeral_participation_enabled) == true
        end
        
        # Given organization.ephemeral_participation_authorization == "valid_auth"
        # permissions => {"vote"=>{"authorization_handlers"=>{"valid_auth"=>{}}}}
        # ephemeral_participation_permissions => ["vote"]
        def ephemeral_participation_permissions
          @ephemeral_participation_permissions ||= begin
            return [] unless ephemeral_participation_enabled?
            return [] unless permissions.present?
            
            permissions.map do |action, authorization_handlers|
              handler_names = authorization_handlers.values.flat_map(&:keys)

              action if handler_names.include?(organization.ephemeral_participation_authorization)
            end.compact
          end
        end
      end
    end
  end
end

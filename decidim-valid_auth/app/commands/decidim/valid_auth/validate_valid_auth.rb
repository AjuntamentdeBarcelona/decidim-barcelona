# frozen_string_literal: true

module Decidim
  module ValidAuth
    class ValidateValidAuth < Decidim::Verifications::PerformAuthorizationStep
      # Executes the command, overwriting the original method in the parent
      # class. Broadcasts these events:
      #
      # - :ok when everything is valid.
      # - :invalid if the handler wasn't valid and we couldn't proceed.
      #
      # Returns nothing.
      def call
        return broadcast(:invalid) unless handler.valid?

        transaction do
          update_verification_data
          authorization.grant!
        end

        broadcast(:ok)
      end
    end
  end
end

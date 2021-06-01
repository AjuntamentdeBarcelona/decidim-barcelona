# frozen_string_literal: true

module Decidim
  module CensusSms
    module Verification
      class SendCode < Rectify::Command
        # Public: Initializes the command.
        #
        # form          - A form object with the params.
        # authorization - The authorization object to update.
        def initialize(form, authorization)
          @form = form
          @authorization = authorization
        end

        # Executes the command
        # Broadcasts these events:
        #
        # - :ok when everything is valid.
        # - :invalid if the handler wasn't valid and we couldn't proceed.
        #
        # Returns nothing.
        def call
          return broadcast(:ok) if update_authorization

          broadcast(:invalid)
        end

        private

        def update_authorization
          metadata = @authorization.metadata
          metadata[:mobile_phone_number] = @form.mobile_phone_number_hash

          @authorization.update(metadata: metadata, verification_metadata: verification_metadata)
        end

        def verification_metadata
          {
            verification_code: @form.verification_code,
            code_sent_at: Time.current
          }
        end
      end
    end
  end
end

# frozen_string_literal: true
module Decidim
  module Debates
    module Admin
      # This command is executed when the user creates a Debate from the admin
      # panel.
      class CreateDebate < Rectify::Command
        def initialize(form)
          @form = form
        end

        # Creates the debate if valid.
        #
        # Broadcasts :ok if successful, :invalid otherwise.
        def call
          return broadcast(:invalid) if @form.invalid?

          create_debate
          broadcast(:ok)
        end

        private

        def create_debate
          Debate.create!(
            # TODO: Params
          )
        end
      end
    end
  end
end

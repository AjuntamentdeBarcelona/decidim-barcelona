# frozen_string_literal: true

require "decidim/core/test/factories"

FactoryBot.define do
  factory :ephemeral_participant, parent: :user do
    managed { true }

    transient do
      authorization_name
    end

    extended_data do
      {
        ephemeral_participation: {
          authorization_name:
        }
      }
    end
  end
end

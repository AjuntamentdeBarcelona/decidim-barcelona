# frozen_string_literal: true

module Decidim
  module InitiativesVoteOverride
    extend ActiveSupport::Concern

    included do
      def sha1
        title = translated_attribute(initiative.title)

        # Use description if present, otherwise concatenate the new fields
        content = translated_attribute(initiative.description).presence || [
          translated_attribute(initiative.question),
          translated_attribute(initiative.objective),
          translated_attribute(initiative.reasons)
        ].compact.join(" ")

        Digest::SHA1.hexdigest "#{authorization_unique_id}#{title}#{content}"
      end
    end
  end
end

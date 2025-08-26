# frozen_string_literal: true

module Decidim
  module InitiativesVotes
    module VoteCellOverride
      extend ActiveSupport::Concern

      included do
        def truncated_timestamp
          return "" if model.timestamp.blank?

          "#{timestamp_result} #{truncated_timestamp_content}"
        end

        private

        def timestamp_result
          extract_key_from_xml("dss:Result")
        end

        def truncated_timestamp_content
          extract_key_from_xml("dss:Timestamp").strip.truncate(256, omission: "...")
        end

        def extract_key_from_xml(key)
          match = model.timestamp.match(%r{<#{key}>(.*?)</#{key}>}m)
          return "" if match.length < 2

          match[1]
        end
      end
    end
  end
end

# frozen_string_literal: true

module Decidim
  module Overrides
    module Exporters
      module InitiativeVotesPdf
        def vote_row(model, index)
          cell = [
            layout.text((index + 1).to_s, style: :vote_td),
            layout.text(model.author.nickname, style: :vote_td),
            layout.text(I18n.l(model.created_at, format: "%Y-%m-%d %H:%M:%S %Z"), style: :vote_td),
            layout.text(truncate(model.hash_id), style: :vote_td)
          ]

          if collect_user_extra_fields
            metadata ||= model.encrypted_metadata ? encryptor.decrypt(model.encrypted_metadata) : {}

            cell += [
              layout.text(metadata[:name_and_surname].presence || "", style: :vote_td),
              layout.text(metadata[:document_number].presence || "", style: :vote_td),
              layout.text(metadata[:date_of_birth].presence || "", style: :vote_td),
              layout.text(metadata[:postal_code].presence || "", style: :vote_td)
            ]
          end

          cell += [
            layout.text(truncated_timestamp(model), style: :vote_td)
          ]
          [cell]
        end

        def truncated_timestamp(model)
          return "" if model.timestamp.blank?

          "#{timestamp_result(model)} #{truncated_timestamp_content(model)}"
        end

        private

        def timestamp_result(model)
          extract_key_from_xml("dss:Result", model)
        end

        def truncated_timestamp_content(model)
          extract_key_from_xml("dss:Timestamp", model).strip.truncate(128, omission: "...")
        end

        def extract_key_from_xml(key, model)
          match = model.timestamp.match(%r{<#{key}>(.*?)</#{key}>}m)
          return "" if match.length < 2

          match[1]
        end
      end
    end
  end
end

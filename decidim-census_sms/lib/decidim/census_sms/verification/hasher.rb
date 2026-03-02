# frozen_string_literal: true

module Decidim
  module CensusSms
    module Verification
      module Hasher
        def self.digest(string)
          Digest::SHA1.hexdigest(
            "#{string}-#{Rails.application.secret_key_base}"
          )
        end
      end
    end
  end
end

# frozen_string_literal: true

# Checks the authorization against the census for Barcelona.
require "digest/md5"

# This class performs a check against the official census database in order
# to verify the citizen's residence.
class Census16AuthorizationHandler < CensusAuthorizationHandler
  def age_limit
    errors.add(:date_of_birth, I18n.t("census16_authorization_handler.age_under", min_age: 16)) unless age && age >= 16
  end
end

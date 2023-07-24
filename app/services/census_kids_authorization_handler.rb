# frozen_string_literal: true

# Checks the authorization against the census for Barcelona.
require "digest/md5"

# This class performs a check against the official census database in order
# to verify the citizen's residence.
class CensusKidsAuthorizationHandler < CensusAuthorizationHandler
  def age_limit
    errors.add(:date_of_birth, I18n.t("census_kids_authorization_handler.age_under", min_age: 10)) unless age && age >= 10
  end
end

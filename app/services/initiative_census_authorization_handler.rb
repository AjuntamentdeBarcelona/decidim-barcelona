# frozen_string_literal: true

# Census authorization handler used exclusively for initiative signatures.
# By having a separate handler_name, its authorizations won't conflict
# with existing census_authorization_handler verifications from registered users.
class InitiativeCensusAuthorizationHandler < CensusAuthorizationHandler
  def user_transferrable?
    duplicate.present? && user&.ephemeral?
  end
end

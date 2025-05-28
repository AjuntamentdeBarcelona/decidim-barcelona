# frozen_string_literal: true

# Checks the authorization against the census for Barcelona.
require "digest/md5"

# This class performs a check against the official census database in order
# to verify the citizen's residence.
class EphemeralCensusAuthorizationHandler < CensusAuthorizationHandler
end

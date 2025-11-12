# frozen_string_literal: true

# Action authorizer for census_authorization_handler that restricts actions by district.
class CensusActionAuthorizer < Decidim::Verifications::DefaultActionAuthorizer
  BASE_OPTION_KEY = "scope_code"

  protected

  def unmatched_fields
    scope_valid? ? [] : [BASE_OPTION_KEY]
  end

  private

  def scope_valid?
    scope_codes = options.keys
                         .select { |k| k.to_s.match?(/^#{BASE_OPTION_KEY}_/) }
                         .select { |k| options[k] == "1" }
                         .map { |k| k.to_s.gsub("#{BASE_OPTION_KEY}_", "") }

    # No district restrictions set, all scopes are valid
    return true if scope_codes.empty?

    authorized_code = authorization.metadata[BASE_OPTION_KEY]
    authorized_code.present? && scope_codes.include?(authorized_code.to_s)
  end
end

# frozen_string_literal: true

# Action authorizer for census_authorization_handler that restricts actions by district.
class CensusActionAuthorizer < Decidim::Verifications::DefaultActionAuthorizer
  BASE_OPTION_KEY = "scope_code"

  def missing_fields
    super - options.keys
  end

  def authorize
    status_code, data = *super

    extra_explanations = []
    if allowed_scopes.present?
      status_code = :unauthorized if status_code == :ok && !scope_valid?

      unless scope_valid?
        i18n_scope = "decidim.authorization_handlers.census_authorization_handler"
        extra_explanations << { key: "extra_explanation",
                                params: { scope: i18n_scope,
                                          count: allowed_scopes.count,
                                          scopes: allowed_scopes.map { |id| I18n.t("#{i18n_scope}.fields.scope_code_#{id}") }.join(", ") } }
      end
    end

    data[:extra_explanation] = extra_explanations if extra_explanations.any?

    [status_code, data]
  end

  private

  def allowed_scopes
    @allowed_scopes = options.keys
                             .select { |k| k.to_s.match?(/^#{BASE_OPTION_KEY}_/) }
                             .select { |k| options[k] == "1" }
                             .map { |k| k.to_s.gsub("#{BASE_OPTION_KEY}_", "") }
  end

  def scope_valid?
    scope = authorization.metadata[BASE_OPTION_KEY]
    scope.present? && allowed_scopes.include?(scope.to_s)
  end
end

# frozen_string_literal: true

# Action authorizer for census_authorization_handler that restricts actions by
# district and by age range
class CensusActionAuthorizer < Decidim::Verifications::DefaultActionAuthorizer
  BASE_OPTION_KEY = "scope_code"
  DEFAULT_MIN_AGE = 14

  def missing_fields
    super - options.keys
  end

  def authorize
    status_code, data = *super

    extra_explanations = []
    status_code = check_scope!(status_code, extra_explanations)
    status_code = check_age!(status_code, extra_explanations)

    data[:extra_explanation] = extra_explanations if extra_explanations.any?

    [status_code, data]
  end

  private

  def check_scope!(status_code, extra_explanations)
    return status_code if allowed_scopes.blank?

    status_code = :unauthorized if status_code == :ok && !scope_valid?

    unless scope_valid?
      extra_explanations << { key: "extra_explanation",
                              params: { scope: i18n_scope,
                                        count: allowed_scopes.count,
                                        scopes: allowed_scopes.map { |id| I18n.t("#{i18n_scope}.fields.scope_code_#{id}") }.join(", ") } }
    end

    status_code
  end

  def check_age!(status_code, extra_explanations)
    status_code = :unauthorized if status_code == :ok && !age_valid?

    unless age_valid?
      extra_explanations << { key: age_explanation_key,
                              params: { scope: i18n_scope, min_age:, max_age: } }
    end

    status_code
  end

  def i18n_scope
    "decidim.authorization_handlers.census_authorization_handler"
  end

  def allowed_scopes
    @allowed_scopes = options.keys
                             .select { |k| k.to_s.match?(/^#{BASE_OPTION_KEY}_/) }
                             .select { |k| options[k] == "1" }
                             .map { |k| k.to_s.gsub("#{BASE_OPTION_KEY}_", "") }
  end

  def scope_valid?
    return false if authorization.nil?

    scope = authorization.metadata[BASE_OPTION_KEY]
    scope.present? && allowed_scopes.include?(scope.to_s)
  end

  # Returns the configured minimum age, clamped to DEFAULT_MIN_AGE. Admins can
  # only raise the baseline; any configured value below DEFAULT_MIN_AGE (or a
  # missing/non-positive value) is overridden so the 14-year floor always
  # holds, regardless of what was stored in the permission options.
  def min_age
    configured = option_value("min_age").presence&.to_i
    return DEFAULT_MIN_AGE unless configured&.positive?

    [configured, DEFAULT_MIN_AGE].max
  end

  # max_age is opt-in: zero or a missing option means "no upper bound".
  def max_age
    configured = option_value("max_age").presence&.to_i
    configured if configured&.positive?
  end

  def option_value(key)
    raw = options[key] || options[key.to_sym]
    value = raw.respond_to?(:value) ? raw.value : raw
    value.to_s
  end

  def age_valid?
    return false if user_age.nil?

    user_age >= min_age && (max_age.nil? || user_age <= max_age)
  end

  def age_explanation_key
    max_age.present? ? "age_extra_explanation_range" : "age_extra_explanation"
  end

  def user_age
    return nil if authorization.nil?

    date_of_birth = parsed_date_of_birth
    return nil if date_of_birth.nil?

    today = Date.current
    extra_year = (today.month > date_of_birth.month) || (today.month == date_of_birth.month && today.day >= date_of_birth.day)
    today.year - date_of_birth.year - (extra_year ? 0 : 1)
  end

  def parsed_date_of_birth
    raw_date_of_birth = authorization.metadata["date_of_birth"] || authorization.metadata[:date_of_birth]
    return nil if raw_date_of_birth.blank?
    return raw_date_of_birth if raw_date_of_birth.is_a?(Date)

    Date.parse(raw_date_of_birth.to_s)
  rescue ArgumentError, TypeError
    nil
  end
end

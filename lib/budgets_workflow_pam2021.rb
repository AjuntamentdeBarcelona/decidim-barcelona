# frozen_string_literal: true

# Specific Workflow for Barcelona's 2021 PAM
class BudgetsWorkflowPam2021 < Decidim::Budgets::Workflows::Base
  PAM2021AUTHORIZATIONHANDLER = "census_sms_authorization_handler"

  # The budget resource in the user's scope is highlighted.
  def highlighted?(resource)
    return false unless user_scope_resource && !voted?(user_scope_resource)

    resource == user_scope_resource
  end

  # Can vote in the budget resource in the user's scope
  # and in an extra budget resource out of its scope
  # rubocop:disable Style/OptionalBooleanParameter
  def vote_allowed?(resource, consider_progress = true)
    return true if resource == user_scope_resource

    resources_with_order = voted
    resources_with_order += progress if consider_progress

    (resources_with_order - [user_scope_resource, resource]).empty?
  end
  # rubocop:enable Style/OptionalBooleanParameter

  # The user can change of mind and change the vote on these budget resources
  #
  # Returns Array.
  def discardable
    (voted + progress) - [user_scope_resource]
  end

  # The user can vote on maximum 2 budget resources
  #
  # Returns Boolean.
  def limit_reached?
    (voted + progress).count < 3
  end

  private

  # Returns Object (Authorization).
  def user_authorization
    @user_authorization ||= Decidim::Authorization.find_by(
      name: PAM2021AUTHORIZATIONHANDLER,
      user:
    )
  end

  # The budget resources the user can and should vote on
  #
  # Returns Object (Decidim::Budgets:Budget).
  def user_scope_resource
    return unless user_authorization_taxonomy

    @user_scope_resource ||= budgets.find do |resource|
      resource.taxonomies.exists?(id: user_authorization_taxonomy.id)
    end
  end

  # The user's district taxonomy resolved from the verification.
  #
  # Returns Object (Decidim::Taxonomy).
  def user_authorization_taxonomy
    return unless user_authorization

    @user_authorization_taxonomy ||= Decidim::Taxonomy.find_by(
      "name ->> 'ca' = ? AND decidim_organization_id = ?",
      user_authorization.metadata["scope"],
      user.organization.id
    )
  end
end

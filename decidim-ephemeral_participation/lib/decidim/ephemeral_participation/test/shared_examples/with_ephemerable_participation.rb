# frozen_string_literal: true

shared_context "with ephemerable participation" do
  let(:manifest) { Decidim.find_component_manifest(manifest_name) }
  let(:user) { create :user, :confirmed, organization: organization }

  let!(:organization) { create(:organization, *organization_traits, available_authorizations: available_authorizations) }

  let(:participatory_process) do
    create(:participatory_process, :with_steps, organization: organization)
  end

  let(:participatory_space) { participatory_process }

  let!(:component) do
    create(:component,
           manifest: manifest,
           participatory_space: participatory_space,
           settings: settings,
           permissions: permissions)
  end

  let(:organization_traits) { [] }

  let(:authorizations) { { ephemerable_authorization => { "allow_ephemeral_participation" => true } } }
  let(:permissions) { { ephemerable_action => { "authorization_handlers" => { ephemerable_authorization => {} } } } }
  let(:settings) { { ephemeral_participation_enabled: true } }

  before do
    if organization_traits.include?(:secure_context)
      switch_to_secure_context_host
    else
      switch_to_host(organization.host)
    end
  end

  def visit_component
    page.visit main_component_path(component)
  end
end

shared_context "when managing a component's ephemerable permissions" do
  let(:current_component) { component }

  before do
    login_as user, scope: :user
    visit_component_admin
  end

  def visit_component_admin
    visit manage_component_path(component)
  end

  # Returns the config path for a given component.
  #
  # component - the Component we want to find the root path for.
  #
  # Returns a url.
  def edit_component_path(component)
    Decidim::EngineRouter.admin_proxy(component.participatory_space).edit_component_path(component.id)
  end
end

shared_context "when managing a component's ephemerable permissions as an admin" do
  include_context "when managing a component's ephemerable permissions" do
    let(:component_organization_traits) { admin_component_organization_traits }
  end

  let(:admin_component_organization_traits) { [] }

  let(:user) do
    create :user,
           :admin,
           :confirmed,
           organization: organization
  end
end

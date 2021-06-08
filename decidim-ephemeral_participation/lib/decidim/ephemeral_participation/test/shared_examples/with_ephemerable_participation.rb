# frozen_string_literal: true

shared_context "with ephemerable participation" do
  let(:regular_user) { create(:user, :confirmed, organization: organization) }
  let(:ephemeral_participant) do
    # decidim-ephemeral_participation/app/commands/decidim/ephemeral_participation/create_ephemeral_participant.rb
    Decidim::User.new(
      organization: component.organization,
      managed: true,
      tos_agreement: true,
      accepted_tos_version: component.organization.tos_version,
      name: I18n.t("decidim.ephemeral_participation.ephemeral_participants.name"),
      extended_data: {
        ephemeral_participation: {
          authorization_name: ephemeral_participable_authorization,
          component_id: component.id,
          permissions:  component.ephemeral_participation_permissions,
          request_path: ephemeral_participation_path
        }
      }
    ).tap do |user|
      user.nickname = Decidim::UserBaseEntity.nicknamize(user.name, organization: user.organization)
      user.save!
    end
  end

  let(:organization) { create(:organization, *organization_traits, available_authorizations: available_authorizations) }
  let(:organization_traits) { [] }
  let(:available_authorizations) do
    { ephemeral_participable_authorization => { "allow_ephemeral_participation" => true } }
  end

  let(:participatory_space) { participatory_process }

  let(:component) do
    create(:component,
           manifest: manifest,
           participatory_space: participatory_space,
           permissions: permissions).tap do |component|
      component.settings = settings
      component.save!
    end
  end
  let(:manifest) { Decidim.find_component_manifest(manifest_name) }
  let(:participatory_process) { create(:participatory_process, organization: organization) }
  let(:permissions) do
    { ephemeral_participable_action => { "authorization_handlers" => { ephemeral_participable_authorization => {} } } }
  end
  let(:settings) do
    {
      ephemeral_participation_enabled: true,
      ephemeral_participation_enabled_confirm_modal: { "en"=>"<p>Are you sure?</p>" }
    }
  end

  let(:authorization) do
    create(
      :authorization,
      :granted,
      name: "dummy_authorization_handler",
      user: authorized_user,
      unique_id: document_number,
      metadata: { document_number: document_number }
    )
  end

  let(:document_number) { "123456789X" }

  def click_ephemeral_participation_button
    page.find(ephemeral_participation_button_selector).click
    accept_confirm { click_button("I want to participate without registering") }
  end

  def submit_authorization_form
    within("form#new_authorization_handler") do
      fill_in("Document number", with: document_number)
      find("*[type=submit]").click
    end
  end

  def submit_unverifiable_form
    within("form#new_unverifiable_ephemeral_participant_") do
      fill_in(:unverifiable_ephemeral_participant_email, with: email)
      find("*[type=submit]").click
    end
  end

  let(:email) { "unique@email.example" }

  def register_workflows
    [
      "decidim-generators/lib/decidim/generators/app_templates/dummy_authorization_handler.rb",
      "decidim-generators/lib/decidim/generators/app_templates/another_dummy_authorization_handler.rb",
    ].each { |file_path| require "#{Gem::Specification.find_by_name("decidim").gem_dir}/#{file_path}" }

    Decidim::Verifications.clear_workflows

    Decidim::Verifications.register_workflow(:dummy_authorization_handler) do |workflow|
      workflow.form = "DummyAuthorizationHandler"
      workflow.ephemerable = true
    end

    Decidim::Verifications.register_workflow(:another_dummy_authorization_handler) do |workflow|
      workflow.form = "AnotherDummyAuthorizationHandler"
      workflow.ephemerable = false
    end
  end

  def visit_component
    page.visit main_component_path(component)
  end

  def expect_user_not_logged
    within(".topbar") do
      expect(page).not_to have_css(".topbar__user__logged")
    end
  end

  def expect_user_logged
    within(".topbar") do
      expect(page).to have_css(".topbar__user__logged")
    end
  end
end

shared_context "when managing a component's ephemerable permissions" do
  include_context "with ephemerable participation"

  let(:current_component) { component }

  def visit_component_admin
    visit manage_component_path(component)
  end

  def edit_component_path(component)
    Decidim::EngineRouter.admin_proxy(component.participatory_space).edit_component_path(component.id)
  end

  def edit_component_permissions_path(component)
    Decidim::EngineRouter.admin_proxy(component.participatory_space).edit_component_permissions_path(component.id)
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

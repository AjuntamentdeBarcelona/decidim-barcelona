# frozen_string_literal: true

require "rails_helper"

describe "Initiative custom fields display" do
  let(:organization) { create(:organization) }
  let(:author) { create(:user, :confirmed, organization:) }
  let(:other_user) { create(:user, :confirmed, organization:) }
  let!(:author_authorization) { create(:authorization, user: author, name: "census_sms_authorization_handler") }
  let!(:other_user_authorization) { create(:authorization, user: other_user, name: "census_sms_authorization_handler") }
  let(:initiatives_type) { create(:initiatives_type, organization:, promoting_committee_enabled: true) }
  let(:scoped_type) { create(:initiatives_type_scope, type: initiatives_type) }

  before do
    switch_to_host(organization.host)
  end

  context "when initiative has custom fields" do
    let(:initiative) do
      create(
        :initiative,
        :created,
        organization:,
        author:,
        scoped_type:,
        question: { ca: "Pregunta de prova", es: "Pregunta de prueba" },
        definition: { ca: "Definició de prova", es: "Definición de prueba" },
        reasons: { ca: "Raons de prova", es: "Razones de prueba" },
        has_custom_fields: true
      )
    end

    it "displays custom fields in committee request view" do
      login_as other_user, scope: :user
      visit decidim_initiatives.new_initiative_committee_request_path(initiative)

      expect(page).to have_content("Pregunta de prov")
      expect(page).to have_content("Definició de prov")
      expect(page).to have_content("Raons de prov")
      expect(page).to have_no_content("Descripció")
    end

    it "displays custom fields in show view" do
      login_as author, scope: :user
      visit decidim_initiatives.initiative_path(initiative)

      expect(page).to have_content("Pregunta de prov")
      expect(page).to have_content("Definició de prov")
      expect(page).to have_content("Raons de prov")
    end

    it "displays custom fields in print view" do
      login_as author, scope: :user
      visit decidim_initiatives.print_initiative_path(initiative)

      expect(page).to have_content("Pregunta de prov")
      expect(page).to have_content("Definició de prov")
      expect(page).to have_content("Raons de prov")
    end
  end

  context "when initiative has legacy description field" do
    let(:initiative) do
      create(
        :initiative,
        :created,
        organization:,
        author:,
        scoped_type:,
        description: { ca: "Descripció antiga", es: "Descripción antigua" },
        has_custom_fields: false
      )
    end

    it "displays description in committee request view" do
      login_as other_user, scope: :user
      visit decidim_initiatives.new_initiative_committee_request_path(initiative)

      expect(page).to have_content("Descripció antiga")
      expect(page).to have_no_content("Pregunta")
      expect(page).to have_no_content("Definició")
      expect(page).to have_no_content("Raons")
    end

    it "displays description in show view" do
      login_as author, scope: :user
      visit decidim_initiatives.initiative_path(initiative)

      expect(page).to have_content("Descripció antiga")
    end
  end
end

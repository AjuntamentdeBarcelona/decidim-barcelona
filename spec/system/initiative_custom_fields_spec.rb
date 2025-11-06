# frozen_string_literal: true

require "rails_helper"

describe "Initiative custom fields display" do
  let(:organization) { create(:organization) }
  let(:user) { create(:user, :confirmed, organization:) }

  before do
    switch_to_host(organization.host)
    login_as user, scope: :user
  end

  context "when initiative has custom fields" do
    let(:initiative) do
      create(
        :initiative,
        :published,
        organization:,
        question: { ca: "Pregunta de prova", es: "Pregunta de prueba" },
        definition: { ca: "Definició de prova", es: "Definición de prueba" },
        reasons: { ca: "Raons de prova", es: "Razones de prueba" },
        has_custom_fields: true
      )
    end

    it "displays custom fields in committee request view" do
      visit decidim_initiatives.new_initiative_committee_request_path(initiative)

      expect(page).to have_content("Pregunta de prov")
      expect(page).to have_content("Definició de prov")
      expect(page).to have_content("Raons de prov")
    end
  end

  context "when initiative has legacy description field" do
    let(:initiative) do
      create(
        :initiative,
        :published,
        organization:,
        description: { ca: "Descripció antiga", es: "Descripción antigua" },
        has_custom_fields: false
      )
    end

    it "displays description in committee request view" do
      visit decidim_initiatives.new_initiative_committee_request_path(initiative)

      expect(page).to have_content("Descripció antiga")
    end
  end
end

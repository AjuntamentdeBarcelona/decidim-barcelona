# frozen_string_literal: true

require "rails_helper"

describe "Initiatives", :perform_enqueued, available_authorizations: ["census_sms_authorization_handler"] do
  include_context "with census sms handler"

  let!(:organization) do
    create(
      :organization,
      name: { ca: "Ajuntament", es: "Ayuntamiento" },
      default_locale: :ca,
      available_locales: [:es, :ca],
      available_authorizations: authorizations
    )
  end

  let!(:base_initiative) do
    create(:initiative, organization:)
  end
  let!(:initiatives_type) { create(:initiatives_type, organization:) }

  let(:authorizations) { ["census_sms_authorization_handler"] }

  let!(:user) { create(:user, :confirmed, organization:) }
  let!(:authorization) { create(:authorization, user:) }

  context "when user is authorized" do
    before do
      switch_to_host(organization.host)
      login_as user, scope: :user
      visit decidim_initiatives.initiatives_path
    end

    it "can create a new initiative" do
      click_on "Nova iniciativa"
      # When there is only an initiative type the user is redirected to the
      # creation form directly
      expect(page).to have_content("Crea una nova iniciativa")
    end
  end

  context "when user is not logged in" do
    before do
      switch_to_host(organization.host)
      visit decidim_initiatives.initiatives_path
    end

    it "cannot create a new initiative" do
      click_on "Nova iniciativa"
      expect(page).to have_content("Si us plau, inicia la sessió")
    end
  end
end

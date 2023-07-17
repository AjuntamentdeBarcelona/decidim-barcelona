# frozen_string_literal: true

require "rails_helper"

describe "Initiatives", type: :system, perform_enqueued: true, available_authorizations: ["census_sms_authorization_handler"] do
  include_context "with census sms handler"

  let!(:organization) do
    create(
      :organization,
      name: "Ajuntament",
      default_locale: :ca,
      available_locales: [:es, :ca],
      available_authorizations: authorizations
    )
  end

  let!(:base_initiative) do
    create(:initiative, organization: organization)
  end
  let!(:initiatives_type) { create(:initiatives_type, organization: organization) }

  let(:authorizations) { ["census_sms_authorization_handler"] }

  let!(:user) { create(:user, :confirmed, organization: organization) }
  let!(:authorization) { create(:authorization, user: user) }

  context "when user is authorized" do
    before do
      switch_to_host(organization.host)
      login_as user, scope: :user
      visit decidim_initiatives.initiatives_path
    end

    it "can create a new initiative" do
      click_link "Nova iniciativa"
      expect(page).to have_content("Quina iniciativa vols iniciar?")
    end
  end

  context "when user is not logged in" do
    before do
      switch_to_host(organization.host)
      visit decidim_initiatives.initiatives_path
    end

    it "cannot create a new initiative" do
      click_button "Nova iniciativa"
      expect(page).to have_content("Si us plau, inicia sessió")
    end
  end
end

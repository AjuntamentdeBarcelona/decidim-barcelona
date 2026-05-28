# frozen_string_literal: true

require "rails_helper"

describe "Author avatar on proposals" do
  include_context "with a component"
  let(:manifest_name) { "proposals" }

  before do
    data_consent(true, visit_root: true)
    visit resource_locator(proposal).path
  end

  context "when the author is official" do
    let!(:proposal) { create(:proposal, :official, skip_injection: true, component:) }

    it "renders the Barcelona official avatar on the proposal detail page" do
      expect(page).to have_css("img.author__avatar[src*='official-avatar']")
    end
  end

  context "when the author is a regular user with an avatar" do
    let(:user) { create(:user, :confirmed, organization:, skip_injection: true) }
    let!(:proposal) { create(:proposal, users: [user], skip_injection: true, component:) }

    it "renders the user's own avatar, not the official nor the default one" do
      expect(page).to have_css("img.author__avatar[src*='/rails/active_storage/']")
      expect(page).to have_no_css("img.author__avatar[src*='official-avatar']")
      expect(page).to have_no_css("img.author__avatar[src*='default-avatar']")
    end
  end

  context "when the author is a deleted user" do
    let(:deleted_user) { create(:user, :confirmed, :deleted, organization:, skip_injection: true) }
    let!(:proposal) { create(:proposal, users: [deleted_user], skip_injection: true, component:) }

    it "renders the default Decidim avatar, not the Barcelona official one" do
      expect(page).to have_css("img.author__avatar[src*='default-avatar']")
      expect(page).to have_no_css("img.author__avatar[src*='official-avatar']")
    end
  end
end

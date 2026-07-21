# frozen_string_literal: true

require "rails_helper"

describe "Admin manages participants invitations" do
  let(:admin) { create(:user, :admin, :confirmed) }
  let(:organization) { admin.organization }

  before do
    switch_to_host(organization.host)
    login_as admin, scope: :user
  end

  context "when a user has a pending invitation" do
    let!(:invited_user) do
      user = build(:user, organization:)
      user.invite!
      user
    end

    before { visit decidim_admin.officializations_path }

    it "can resend the invitation" do
      expect do
        within "tr[data-user-id=\"#{invited_user.id}\"]" do
          find("button[data-controller='dropdown']").click
          click_on "Resend invitation"
        end

        expect(page).to have_content("Invitation successfully resent")
      end.to(change { invited_user.reload.invitation_token })
    end
  end

  context "when a user has accepted the invitation" do
    let!(:invited_user) do
      user = build(:user, organization:)
      user.invite!
      user.accept_invitation!
      user
    end

    before { visit decidim_admin.officializations_path }

    it "does not show the resend invitation action" do
      within "tr[data-user-id=\"#{invited_user.id}\"]" do
        find("button[data-controller='dropdown']").click
        expect(page).to have_no_content("Resend invitation")
      end
    end
  end

  context "when a user has never been invited" do
    let!(:regular_user) { create(:user, :confirmed, organization:) }

    before { visit decidim_admin.officializations_path }

    it "does not show the resend invitation action" do
      within "tr[data-user-id=\"#{regular_user.id}\"]" do
        find("button[data-controller='dropdown']").click
        expect(page).to have_no_content("Resend invitation")
      end
    end
  end
end

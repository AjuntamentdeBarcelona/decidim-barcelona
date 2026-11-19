# frozen_string_literal: true

require "rails_helper"
require "decidim/meetings_guest_registrations/test/factories"

# The app copy of join_meeting_button/show.erb wins over the one in
# decidim-meetings_guest_registrations, so it has to keep the guest branch.
describe "Meetings guest registration" do
  let(:organization) { create(:organization) }
  let(:participatory_process) { create(:participatory_process, :published, organization:) }
  let(:component) { create(:meeting_component, :published, participatory_space: participatory_process) }
  let!(:meeting) do
    create(:meeting, :published,
           component:,
           author: organization,
           registrations_enabled: true,
           registration_form_enabled: false,
           available_slots: 10,
           reserved_slots: 0,
           registration_terms: { en: "The registration terms" },
           guest_registrations_enabled: true,
           guest_registrations_privacy_text: { en: "The data protection text" })
  end
  let(:guest_registration_path) do
    Decidim::EngineRouter.main_proxy(component).new_meeting_guest_registration_path(meeting_id: meeting.id)
  end

  before do
    stub_geocoding_coordinates([meeting.latitude, meeting.longitude])
    switch_to_host(organization.host)
  end

  it "lets a visitor register without an account from the meeting page" do
    visit resource_locator(meeting).path
    click_on "Register to the meeting"

    expect(page).to have_current_path(guest_registration_path, ignore_query: true)
    expect(page).to have_content("The data protection text")

    fill_in "Name and surname", with: "Ana Guest"
    fill_in "Email", with: "ana@example.org"
    fill_in "Phone", with: "+34 600 123 456"
    check "I have read and accept the data protection information"
    check "I accept the registration terms"
    click_on "Register"

    expect(page).to have_content("Your registration has been confirmed")
    expect(meeting.registrations.guests.count).to eq(1)
  end

  context "when the user is signed in" do
    let(:user) { create(:user, :confirmed, organization:) }

    before { login_as user, scope: :user }

    it "keeps the regular registration flow" do
      visit resource_locator(meeting).path

      expect(page).to have_button("Register to the meeting")
      expect(page).to have_no_link(href: guest_registration_path)
    end
  end
end

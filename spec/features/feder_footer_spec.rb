# frozen_string_literal: true

require "rails_helper"

feature "new registration" do
  let(:organization) { create :organization }

  before do
    app_host = (organization.host ? "http://#{organization.host}:3000" : nil)
    Capybara.app_host = app_host
  end

  scenario "display feder logo on footer on homepage" do
    visit '/'
    expect(page).to have_content "Fons Europeu de Desenvolupament Regional"
  end

  scenario "display feder logo on footer on user registration page" do
    visit '/users/sign_up'
    expect(page).to have_content "Fons Europeu de Desenvolupament Regional"
  end
end

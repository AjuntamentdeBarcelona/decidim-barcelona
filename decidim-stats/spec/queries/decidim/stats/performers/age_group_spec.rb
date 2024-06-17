# frozen_string_literal: true

require "rails_helper"

describe Decidim::Stats::Performers::AgeGroup do
  include ActiveSupport::Testing::TimeHelpers

  subject do
    described_class.new(performer_age_group)
  end

  let(:authorization_age_group) { "20-24" }
  let(:performer_age_group) { authorization_age_group }
  let(:user) { create(:user) }
  let!(:authorization) do
    create(
      :authorization,
      user:,
      name: "census_sms_authorization_handler",
      metadata: {
        date_of_birth: "2000-01-01"
      }
    )
  end

  before do
    travel_to Time.zone.local 2020, 1, 2
  end

  after do
    travel_back
  end

  context "when looking for authorizations matching the age group" do
    it "finds the user" do
      expect(subject.query).to contain_exactly(user)
    end
  end

  context "when looking for authorizations but the age groups do not match" do
    let(:performer_age_group) { "50-54" }

    it "cannot find the user" do
      expect(subject.query).to be_empty
    end
  end
end

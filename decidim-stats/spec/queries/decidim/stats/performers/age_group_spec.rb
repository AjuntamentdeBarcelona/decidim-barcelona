# frozen_string_literal: true

require "rails_helper"

describe Decidim::Stats::Performers::AgeGroup do
  include ActiveSupport::Testing::TimeHelpers

  let(:authorization_age_group) { "20-24" }
  let(:performer_age_group) { authorization_age_group }
  let(:user) { create :user }
  let!(:authorization) do
   create(
     :authorization,
     user: user,
     name: "census_handler_authorization" ,
     metadata: {
       date_of_birth: "2000-01-01"
     }
   )
  end

  subject do
    described_class.new(performer_age_group)
  end

  before do
    travel_to Time.zone.local 2020, 01, 02
  end

  after do
    travel_back
  end

  context "when looking for authorizations matching the age group" do
    it "finds the user" do
      expect(subject.query).to eq([user])
    end
  end

  context "when looking for authorizations but the age groups do not match" do
    let(:performer_age_group) { "50-54" }

    it "cannot find the user" do
      expect(subject.query).to eq([])
    end
  end
end

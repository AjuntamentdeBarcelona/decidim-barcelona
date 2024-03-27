# frozen_string_literal: true

require "rails_helper"

describe Decidim::Stats::Performers::District do
  subject do
    described_class.new(performer_district)
  end

  let(:authorization_district) { "My district" }
  let(:performer_district) { authorization_district }
  let(:user) { create(:user) }
  let!(:authorization) do
    create(
      :authorization,
      user:,
      name: "census_sms_authorization_handler",
      metadata: {
        scope: authorization_district
      }
    )
  end

  context "when looking for authorizations matching the scope" do
    it "finds the user" do
      expect(subject.query).to contain_exactly(user)
    end
  end

  context "when looking for authorizations but the scopes do not match" do
    let(:performer_district) { "Another district" }

    it "cannot find the user" do
      expect(subject.query).to be_empty
    end
  end
end

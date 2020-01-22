# frozen_string_literal: true

require "rails_helper"

describe Decidim::Stats::Performers::District do
  subject do
    described_class.new(performer_district)
  end

  let(:authorization_district) { "My district" }
  let(:performer_district) { authorization_district }
  let(:user) { create :user }
  let!(:authorization) do
    create(
      :authorization,
      user: user,
      name: "census_handler_authorization",
      metadata: {
        scope: authorization_district
      }
    )
  end

  context "when looking for authorizations matching the scope" do
    it "finds the user" do
      expect(subject.query).to eq([user])
    end
  end

  context "when looking for authorizations but the scopes do not match" do
    let(:performer_district) { "Another district" }

    it "cannot find the user" do
      expect(subject.query).to eq([])
    end
  end
end

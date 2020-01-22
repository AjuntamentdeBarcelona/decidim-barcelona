# frozen_string_literal: true

require "rails_helper"

describe Decidim::Stats::Performers::Gender do
  subject do
    described_class.new(performer_gender)
  end

  let(:authorization_gender) { "foo" }
  let(:performer_gender) { authorization_gender }
  let(:user) { create :user }
  let!(:authorization) do
    create(
      :authorization,
      user: user,
      name: "census_handler_authorization",
      metadata: {
        gender: authorization_gender
      }
    )
  end

  context "when looking for authorizations matching the gender" do
    it "finds the user" do
      expect(subject.query).to eq([user])
    end
  end

  context "when looking for authorizations but the genders do not match" do
    let(:performer_gender) { "bar" }

    it "cannot find the user" do
      expect(subject.query).to eq([])
    end
  end
end

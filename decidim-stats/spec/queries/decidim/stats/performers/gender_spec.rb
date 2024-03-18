# frozen_string_literal: true

require "rails_helper"

describe Decidim::Stats::Performers::Gender do
  subject do
    described_class.new(performer_gender)
  end

  let(:authorization_gender) { "foo" }
  let(:performer_gender) { authorization_gender }
  let(:user) { create(:user) }
  let!(:authorization) do
    create(
      :authorization,
      user:,
      name: "census_sms_authorization_handler",
      metadata: {
        extras: {
          gender: authorization_gender
        }
      }
    )
  end

  context "when looking for authorizations matching the gender" do
    it "finds the user" do
      expect(subject.query).to contain_exactly(user)
    end
  end

  context "when looking for authorizations but the genders do not match" do
    let(:performer_gender) { "bar" }

    it "cannot find the user" do
      expect(subject.query).to be_empty
    end
  end
end

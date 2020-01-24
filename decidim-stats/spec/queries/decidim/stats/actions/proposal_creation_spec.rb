# frozen_string_literal: true

require "rails_helper"
require "decidim/proposals/test/factories"

describe Decidim::Stats::Actions::ProposalCreation do
  subject do
    described_class.new(component, performers_query)
  end

  let(:performers_query) { Decidim::User.all }
  let!(:proposal) { create :proposal }
  let(:user) { proposal.authors.first }
  let(:component) { proposal.component }

  context "when looking for proposal authors matching the component" do
    it "finds the user ID" do
      expect(subject.query).to eq([user.id])
    end
  end

  context "when looking for proposal authors but the performers do not match" do
    let(:performers_query) { Decidim::User.none }

    it "cannot find the user" do
      expect(subject.query).to eq([])
    end
  end

  context "when looking for proposal authors but the components do not match" do
    let(:component) { create :component }

    it "cannot find the user" do
      expect(subject.query).to eq([])
    end
  end
end

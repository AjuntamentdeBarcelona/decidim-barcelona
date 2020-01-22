# frozen_string_literal: true

require "rails_helper"
require "decidim/proposals/test/factories"

describe Decidim::Stats::Actions::Follow do
  let(:performers_query) { Decidim::User.all }
  let!(:proposal) { create :proposal }
  let(:component) { proposal.component }
  let!(:proposal_follow) { create :follow, followable: proposal }
  let!(:proposal_follower) { proposal_follow.user }
  let!(:draft) { create :collaborative_draft, component: component }
  let!(:draft_follow) { create :follow, followable: draft }
  let!(:draft_follower) { draft_follow.user }

  subject do
    described_class.new(component, performers_query)
  end

  context "when looking for follow authors matching the component" do
    it "finds the user IDs following any resource in the component" do
      expect(subject.query).to eq([proposal_follower.id, draft_follower.id])
    end
  end

  context "when looking for follow authors but the performers do not match" do
    let(:performers_query) { Decidim::User.none }

    it "cannot find the user" do
      expect(subject.query).to eq([])
    end
  end

  context "when looking for follow authors but the components do not match" do
    let(:component) { create :component }

    it "cannot find the user" do
      expect(subject.query).to eq([])
    end
  end
end

# frozen_string_literal: true

require "rails_helper"
require "decidim/proposals/test/factories"

describe Decidim::Stats::Actions::Follow do
  subject do
    described_class.new(component, performers_query)
  end

  let(:performers_query) { Decidim::User.all }
  let!(:proposal) { create(:proposal) }
  let(:component) { proposal.component }
  let!(:proposal_follow) { create(:follow, followable: proposal) }
  let!(:proposal_follower) { proposal_follow.user }
  let!(:other_proposal) { create(:proposal, component: proposal.component) }
  let!(:other_follow) { create(:follow, followable: other_proposal) }
  let!(:other_follower) { other_follow.user }
  let(:followers) { proposal.authors.pluck(:id) | other_proposal.authors.pluck(:id) | [proposal_follower.id, other_follower.id] }

  context "when looking for follow authors matching the component" do
    it "finds the user IDs following any resource in the component" do
      expect(subject.query).to match_array(followers)
    end
  end

  context "when looking for follow authors but the performers do not match" do
    let(:performers_query) { Decidim::User.none }

    it "cannot find the user" do
      expect(subject.query).to be_empty
    end
  end

  context "when looking for follow authors but the components do not match" do
    let(:component) { create(:component) }

    it "cannot find the user" do
      expect(subject.query).to be_empty
    end
  end
end

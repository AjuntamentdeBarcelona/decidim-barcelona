# frozen_string_literal: true

require "rails_helper"
require "decidim/proposals/test/factories"
require "decidim/comments/test/factories"

describe Decidim::Stats::Actions::Comment do
  subject do
    described_class.new(component, performers_query)
  end

  let(:performers_query) { Decidim::User.all }
  let!(:proposal) { create :proposal }
  let(:component) { proposal.component }
  let!(:draft) { create :collaborative_draft, component: component }
  let!(:comment) { create :comment, root_commentable: proposal }
  let(:proposal_comment_author) { comment.author }
  let!(:draft_comment) { create :comment, root_commentable: draft }
  let(:draft_comment_author) { draft_comment.author }

  context "when looking for comments authors matching the component" do
    it "finds the author IDs of comments on any commentable resource in the component" do
      expect(subject.query).to eq([proposal_comment_author.id, draft_comment_author.id])
    end
  end

  context "when looking for comments authors but the performers do not match" do
    let(:performers_query) { Decidim::User.none }

    it "cannot find the user" do
      expect(subject.query).to eq([])
    end
  end

  context "when looking for comments authors but the components do not match" do
    let(:component) { create :component }

    it "cannot find the user" do
      expect(subject.query).to eq([])
    end
  end
end

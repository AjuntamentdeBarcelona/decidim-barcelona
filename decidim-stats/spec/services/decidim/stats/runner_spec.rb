# frozen_string_literal: true

require "rails_helper"
require "decidim/proposals/test/factories"

describe Decidim::Stats::Runner do
  include ActiveSupport::Testing::TimeHelpers

  subject do
    described_class.new(
      minimum_count: minimum_count
    ).run
  end

  let(:performers_query) { Decidim::User.all }
  let!(:proposal) { create :proposal }
  let(:proposal_author) { proposal.authors.first }
  let(:component) { proposal.component }
  let!(:proposal_follow) { create :follow, followable: proposal }
  let!(:proposal_follower) { proposal_follow.user }
  let!(:draft) { create :collaborative_draft, component: component }
  let!(:draft_follow) { create :follow, followable: draft }
  let!(:draft_follower) { draft_follow.user }
  let!(:endorsement) { create :proposal_endorsement, proposal: proposal }
  let(:proposal_endorser) { endorsement.author }
  let!(:comment) { create :comment, root_commentable: proposal }
  let(:proposal_comment_author) { comment.author }
  let!(:vote) { create :proposal_vote, proposal: proposal }
  let(:proposal_vote_author) { vote.author }

  let(:scope_name) { "My scope" }
  let!(:scope) { create :scope, name: { ca: scope_name } }

  let(:minimum_count) { 1 }

  let(:users) do
    [
      proposal_author,
      proposal_follower,
      draft_follower,
      proposal_endorser,
      proposal_comment_author,
      proposal_vote_author
    ]
  end

  before do
    users.each_with_index do |user, index|
      create(
        :authorization,
        user: user,
        name: "census_authorization_handler",
        metadata: {
          scope: scope_name,
          date_of_birth: "#{2000 - index * 2}-01-01",
          gender: %w(man woman woman non_binary non_binary man)[index]
        }
      )
    end

    travel_to Time.zone.local 2020, 1, 2
  end

  after do
    travel_back
  end

  it "counts the comments" do
    data = subject.select { |(_, _, _, action, _, _), _| action == :comment }.to_a
    expect(data.count).to eq 3

    expect(data[0].first[4]).to eq :age_group
    expect(data[0].first[5]).to eq "25-29"
    expect(data[0].last).to eq 1

    expect(data[1].first[4]).to eq :district
    expect(data[1].first[5]).to eq scope_name
    expect(data[1].last).to eq 1

    expect(data[2].first[4]).to eq :gender
    expect(data[2].first[5]).to eq "non_binary"
    expect(data[2].last).to eq 1
  end

  it "counts the endorsements" do
    data = subject.select { |(_, _, _, action, _, _), _| action == :endorsement }.to_a
    expect(data.count).to eq 3

    expect(data[0].first[4]).to eq :age_group
    expect(data[0].first[5]).to eq "25-29"
    expect(data[0].last).to eq 1

    expect(data[1].first[4]).to eq :district
    expect(data[1].first[5]).to eq scope_name
    expect(data[1].last).to eq 1

    expect(data[2].first[4]).to eq :gender
    expect(data[2].first[5]).to eq "non_binary"
    expect(data[2].last).to eq 1
  end

  it "counts the follows" do
    data = subject.select { |(_, _, _, action, _, _), _| action == :follow }.to_a
    expect(data.count).to eq 5

    expect(data[0].first[4]).to eq :age_group
    expect(data[0].first[5]).to eq "20-24"
    expect(data[0].last).to eq 2

    expect(data[0].first[4]).to eq :age_group
    expect(data[0].first[5]).to eq "25-29"
    expect(data[0].last).to eq 1

    expect(data[1].first[4]).to eq :district
    expect(data[1].first[5]).to eq scope_name
    expect(data[1].last).to eq 3

    expect(data[2].first[4]).to eq :gender
    expect(data[2].first[5]).to eq "man"
    expect(data[2].last).to eq 1

    expect(data[3].first[4]).to eq :gender
    expect(data[3].first[5]).to eq "woman"
    expect(data[3].last).to eq 2
  end

  it "counts the proposal creations" do
    data = subject.select { |(_, _, _, action, _, _), _| action == :proposal_creation }.to_a
    expect(data.count).to eq 3

    expect(data[0].first[4]).to eq :age_group
    expect(data[0].first[5]).to eq "20-24"
    expect(data[0].last).to eq 1

    expect(data[1].first[4]).to eq :district
    expect(data[1].first[5]).to eq scope_name
    expect(data[1].last).to eq 1

    expect(data[2].first[4]).to eq :gender
    expect(data[2].first[5]).to eq "man"
    expect(data[2].last).to eq 1
  end

  it "counts the proposal votes" do
    data = subject.select { |(_, _, _, action, _, _), _| action == :proposal_vote }.to_a
    expect(data.count).to eq 3

    expect(data[0].first[4]).to eq :age_group
    expect(data[0].first[5]).to eq "30-34"
    expect(data[0].last).to eq 1

    expect(data[1].first[4]).to eq :district
    expect(data[1].first[5]).to eq scope_name
    expect(data[1].last).to eq 1

    expect(data[2].first[4]).to eq :gender
    expect(data[2].first[5]).to eq "man"
    expect(data[2].last).to eq 1
  end

  it "counts the interactions" do
    data = subject.select { |(_, _, _, action, _, _), _| action == :interactions }.to_a
    expect(data.count).to eq 7

    expect(data[0].first[4]).to eq :age_group
    expect(data[0].first[5]).to eq "20-24"
    expect(data[0].last).to eq 2

    expect(data[1].first[4]).to eq :age_group
    expect(data[1].first[5]).to eq "25-29"
    expect(data[1].last).to eq 2

    expect(data[2].first[4]).to eq :age_group
    expect(data[2].first[5]).to eq "30-34"
    expect(data[2].last).to eq 1

    expect(data[3].first[4]).to eq :district
    expect(data[3].first[5]).to eq scope_name
    expect(data[3].last).to eq 6

    expect(data[4].first[4]).to eq :gender
    expect(data[4].first[5]).to eq "man"
    expect(data[4].last).to eq 2

    expect(data[5].first[4]).to eq :gender
    expect(data[5].first[5]).to eq "woman"
    expect(data[5].last).to eq 2

    expect(data[6].first[4]).to eq :gender
    expect(data[6].first[5]).to eq "non_binary"
    expect(data[6].last).to eq 2
  end

  context "when the data does not reach the minimum count param" do
    let(:minimum_count) { 5 }

    it "only shows the relevant stats" do
      expect(subject.count).to eq 1
      data = subject.to_a

      expect(data[0].first[4]).to eq :district
      expect(data[0].first[5]).to eq scope_name
      expect(data[0].last).to eq 6
    end
  end
end

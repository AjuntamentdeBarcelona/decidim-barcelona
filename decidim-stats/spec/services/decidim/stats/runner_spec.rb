# frozen_string_literal: true

require "rails_helper"
require "decidim/dev/test/rspec_support/component"
require "decidim/proposals/test/factories"

describe Decidim::Stats::Runner do
  include ActiveSupport::Testing::TimeHelpers

  subject do
    described_class.new(
      minimum_count:
    ).run
  end

  let(:performers_query) { Decidim::User.all }
  let!(:proposal) { create(:proposal) }
  let(:proposal_author) { proposal.authors.first }
  let(:component) { proposal.component }
  let!(:proposal_follow) { create(:follow, followable: proposal) }
  let!(:proposal_follower) { proposal_follow.user }
  let!(:draft) { create(:collaborative_draft, component:) }
  let!(:draft_follow) { create(:follow, followable: draft) }
  let!(:draft_follower) { draft_follow.user }
  let!(:like) { create(:like, resource: proposal, author: create(:user, organization: proposal.organization)) }
  let(:proposal_liker) { like.author }
  let!(:comment) { create(:comment, root_commentable: proposal) }
  let(:proposal_comment_author) { comment.author }
  let!(:vote) { create(:proposal_vote, proposal:) }
  let(:proposal_vote_author) { vote.author }

  let(:scope_name) { "My scope" }
  let!(:scope) { create(:scope, name: { ca: scope_name }) }

  let(:minimum_count) { 1 }

  let(:users) do
    [
      proposal_author,
      proposal_follower,
      draft_follower,
      proposal_liker,
      proposal_comment_author,
      proposal_vote_author
    ]
  end

  before do
    users.each_with_index do |user, index|
      create(
        :authorization,
        user:,
        name: "census_sms_authorization_handler",
        metadata: {
          scope: scope_name,
          date_of_birth: "#{2000 - (index * 2)}-01-01",
          extras: {
            gender: %w(man woman woman non_binary non_binary man)[index]
          }
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

    check_data_element(data[0], :age_group, "25-29", 1)

    check_data_element(data[1], :district, scope_name, 1)

    check_data_element(data[2], :gender, "non_binary", 1)
  end

  it "counts the likes" do
    data = subject.select { |(_, _, _, action, _, _), _| action == :like }.to_a
    expect(data.count).to eq 3

    check_data_element(data[0], :age_group, "25-29", 1)

    check_data_element(data[1], :district, scope_name, 1)

    check_data_element(data[2], :gender, "non_binary", 1)
  end

  it "counts the follows" do
    data = subject.select { |(_, _, _, action, _, _), _| action == :follow }.to_a
    expect(data.count).to eq 5

    check_data_element(data[0], :age_group, "20-24", 2)

    check_data_element(data[1], :age_group, "25-29", 1)

    check_data_element(data[2], :district, scope_name, 3)

    check_data_element(data[3], :gender, "man", 1)

    check_data_element(data[4], :gender, "woman", 2)
  end

  it "counts the proposal creations" do
    data = subject.select { |(_, _, _, action, _, _), _| action == :proposal_creation }.to_a
    expect(data.count).to eq 3

    check_data_element(data[0], :age_group, "20-24", 1)

    check_data_element(data[1], :district, scope_name, 1)

    check_data_element(data[2], :gender, "man", 1)
  end

  it "counts the proposal votes" do
    data = subject.select { |(_, _, _, action, _, _), _| action == :proposal_vote }.to_a
    expect(data.count).to eq 3

    check_data_element(data[0], :age_group, "30-34", 1)

    check_data_element(data[1], :district, scope_name, 1)

    check_data_element(data[2], :gender, "man", 1)
  end

  it "counts the interactions" do
    data = subject.select { |(_, _, _, action, _, _), _| action == :interactions }.to_a
    expect(data.count).to eq 7

    check_data_element(data[0], :age_group, "20-24", 2)

    check_data_element(data[1], :age_group, "25-29", 3)

    check_data_element(data[2], :age_group, "30-34", 1)

    check_data_element(data[3], :district, scope_name, 6)

    check_data_element(data[4], :gender, "man", 2)

    check_data_element(data[5], :gender, "woman", 2)

    check_data_element(data[6], :gender, "non_binary", 2)
  end

  context "when the data does not reach the minimum count param" do
    let(:minimum_count) { 5 }

    it "only shows the relevant stats" do
      expect(subject.count).to eq 1
      data = subject.to_a

      check_data_element(data[0], :district, scope_name, 6)
    end
  end

  def check_data_element(element, performer, section, amount)
    expect(element.first[4]).to eq performer
    expect(element.first[5]).to eq section
    expect(element.last).to eq amount
  end
end

# frozen_string_literal: true

require "rails_helper"
require "decidim/proposals/test/factories"

describe Decidim::Stats::Actions::Like do
  subject do
    described_class.new(my_component, performers_query)
  end

  let(:performers_query) { Decidim::User.all }
  let(:proposal) { create(:proposal) }
  let!(:like) { create(:like, resource: proposal, author: build(:user, organization: proposal.organization)) }
  let(:user) { like.author }
  let(:my_component) { like.resource.component }

  context "when looking for likes matching the component" do
    it "finds the user ID" do
      expect(subject.query).to contain_exactly(user.id)
    end
  end

  context "when looking for likes but the performers do not match" do
    let(:performers_query) { Decidim::User.none }

    it "cannot find the user" do
      expect(subject.query).to be_empty
    end
  end

  context "when looking for likes but the components do not match" do
    let(:my_component) { create(:component) }

    it "cannot find the user" do
      expect(subject.query).to be_empty
    end
  end
end

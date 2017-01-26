# frozen_string_literal: true

require "spec_helper"

describe Decidim::Debates::Debate do
  let(:debate) { build :debate }
  subject { debate }

  it_behaves_like "authorable"

  it { is_expected.to be_valid }

  context "without a title" do
    let(:debate) { build :debate, title: nil }

    it { is_expected.not_to be_valid }
  end

  context "when the author is from another organization" do
    subject { build(:debate, author: create(:user))}

    it { is_expected.to be_invalid}
  end
end

# frozen_string_literal: true

require "spec_helper"

describe Decidim::Debates::Debate do
  let(:debate) { build :debate }
  subject { debate }

  it { is_expected.to be_valid }

  context "without a title" do
    let(:debate) { build :debate, title: nil }

    it { is_expected.not_to be_valid }
  end

  context "when the scope is from another organization" do
    let(:scope) { create :scope }
    let(:debate) { build :debate, scope: scope }

    it { is_expected.not_to be_valid }
  end
end

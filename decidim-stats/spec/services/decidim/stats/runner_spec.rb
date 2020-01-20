# frozen_string_literal: true

require "rails_helper"

describe Decidim::Stats::Runner do
  subject do
    described_class.new(
      minimum_count: 1
    )
  end

  context "when everything is OK" do
    it "works" do
      expect(subject.run).to eq({})
    end
  end
end

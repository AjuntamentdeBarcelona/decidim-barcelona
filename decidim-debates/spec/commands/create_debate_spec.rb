# encoding: utf-8
# frozen_string_literal: true
require "spec_helper"

describe Decidim::Debates::Admin::CreateDebate do
  let(:organization) { create :organization, available_locales: [:ca, :es] }
  let(:participatory_process) { create :participatory_process, organization: organization }
  let(:current_feature) { create :feature, participatory_process: participatory_process, manifest_name: "debates" }
  let(:category) { create :category, participatory_process: participatory_process }
  let(:form) do
    double(
      invalid?: invalid,
      title: { ca: "title" },
      description: { ca: "description" },
      instructions: { ca: "instructions" },
      start_time: 1.day.from_now,
      end_time: 1.day.from_now + 1.hour,
      category: category,
      current_feature: current_feature
    )
  end
  let(:invalid) { false }

  subject { described_class.new(form) }

  context "when the form is not valid" do
    let(:invalid) { true }

    it "is not valid" do
      expect { subject.call }.to broadcast(:invalid)
    end
  end

  context "when everything is ok" do
    let(:debate) { Decidim::Debates::Debate.last }

    it "creates the debate" do
      expect { subject.call }.to change { Decidim::Debates::Debate.count }.by(1)
    end

    it "sets the category" do
      subject.call
      expect(debate.category).to eq category
    end

    it "sets the feature" do
      subject.call
      expect(debate.feature).to eq current_feature
    end
  end
end

# coding: utf-8
# frozen_string_literal: true
require "rails_helper"
require "decidim/core/test/factories"
require "decidim/accountability/test/factories"
require "decidim/participatory_processes/test/factories"

describe Decidim::Accountability::ResultsCSVImporter do
  let(:organization) { create :organization, available_locales: [:en] }
  let(:current_user) { create :user, organization: organization }
  let(:participatory_process) { create :participatory_process, organization: organization }
  let(:current_feature) { create :accountability_feature, participatory_space: participatory_process }
  let(:valid_csv) { File.read("spec/fixtures/valid_results.csv") }
  let(:invalid_csv) { File.read("spec/fixtures/invalid_results.csv") }
  let!(:parent_result) { create :result, feature: current_feature, external_id: "pm-act-423" }

  context "with a valid CSV" do
    subject { described_class.new(current_feature, valid_csv, current_user) }

    describe "#import!" do
      context "when results are new" do
        it "should import them" do
          expect { subject.import! }.to change { Decidim::Accountability::ResultWithWeightedProgress.count }.by(2)
        end
      end

      context "when results exist" do
        let!(:result1) { create :result, feature: current_feature, external_id: "8", progress: 0 }
        let!(:result2) { create :result, feature: current_feature, external_id: "9", progress: 0 }

        it "should update them" do
          subject.import!

          expect(result1.reload.progress.to_f).to eq 100
          expect(result2.reload.progress.to_f).to eq 89
          expect(result1.weight).to eq(0.5)
          expect(result2.weight).to eq(0.45)
        end

        it "shouldn't create new results" do
          expect { subject.import! }.to_not change { Decidim::Accountability::ResultWithWeightedProgress.count }
        end
      end
    end
  end

  context "with an invalid CSV" do
    subject { described_class.new(current_feature, invalid_csv, current_user) }

    describe "#import!" do
      it "should return errors" do
        errors = subject.import!

        expect(errors.length).to eq 2
      end
    end
  end
end

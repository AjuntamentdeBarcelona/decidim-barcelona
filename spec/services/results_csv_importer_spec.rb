# frozen_string_literal: true

require "rails_helper"
require "decidim/core/test/factories"
require "decidim/accountability/test/factories"
require "decidim/participatory_processes/test/factories"

module Decidim::Accountability
  describe ResultsCSVImporter do
    let(:organization) { create :organization, available_locales: [:ca, :en] }
    let(:current_user) { create :user, organization: organization }
    let(:participatory_process) { create :participatory_process, organization: organization }
    let(:current_component) { create :accountability_component, participatory_space: participatory_process }
    let(:valid_csv) { File.read("spec/fixtures/valid_results.csv") }
    let(:invalid_csv) { File.read("spec/fixtures/invalid_results.csv") }
    let!(:parent_result) { create :result, component: current_component, external_id: "pm-act-423" }

    context "with a valid CSV" do
      subject { described_class.new(current_component, valid_csv, current_user) }

      describe "#import!" do
        context "when results are new" do
          it "imports them" do
            expect { subject.import! }.to change { Decidim::Accountability::ResultWithWeightedProgress.count }.by(2)
          end
        end

        context "when results exist" do
          let!(:result1) { create :result, component: current_component, external_id: "8", progress: 0 }
          let!(:result2) { create :result, component: current_component, external_id: "9", progress: 0 }

          it "updates them" do
            subject.import!

            expect(result1.reload.progress.to_f).to eq 100
            expect(result2.reload.progress.to_f).to eq 89
            expect(result1.weight).to eq(0.5)
            expect(result2.weight).to eq(0.45)
          end

          it "does not create new results" do
            expect { subject.import! }.not_to(change { Decidim::Accountability::ResultWithWeightedProgress.count })
          end
        end
      end
    end

    context "with an invalid CSV" do
      subject { described_class.new(current_component, invalid_csv, current_user) }

      describe "#import!" do
        it "returns errors" do
          errors = subject.import!

          expect(errors.length).to eq 2
        end
      end
    end
  end
end

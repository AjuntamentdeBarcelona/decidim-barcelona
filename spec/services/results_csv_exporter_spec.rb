# frozen_string_literal: true

require "rails_helper"
require "decidim/core/test/factories"
require "decidim/accountability/test/factories"
require "decidim/participatory_processes/test/factories"

module Decidim::Accountability
  describe ResultsCsvExporter do
    subject { described_class.new(current_component) }

    let(:organization) { create(:organization, available_locales: [:ca, :en]) }
    let(:current_user) { create(:user, organization:) }
    let(:participatory_process) { create(:participatory_process, organization:) }
    let(:current_component) { create(:accountability_component, participatory_space: participatory_process) }
    let!(:parent_result) { create(:result, component: current_component, external_id: "pm-act-423") }

    describe "#export" do
      before do
        csv_export = subject.export

        csv = CSV.parse(csv_export, headers: true)

        expect(csv.count).to eq 1
        @first_row = csv[0]
      end

      it "updates them" do
        expect(@first_row["external_id"]).to eq(parent_result.external_id)
        expect(@first_row["relative_weight"].to_f).to eq(parent_result.weight * 100.0)
        expect(@first_row["result_id"].to_i).to eq(parent_result.id)
      end

      context "when result is nil" do
        let!(:parent_result) { create(:result, component: current_component, external_id: "pm-act-423", weight: nil) }

        it "exports weight as 0" do
          expect(@first_row["relative_weight"].to_f).to eq(0.0)
        end
      end
    end
  end
end

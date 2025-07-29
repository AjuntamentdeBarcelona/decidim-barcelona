# frozen_string_literal: true

require "rails_helper"

module Decidim
  module Accountability
    describe Result do
      subject { result }

      let(:result) { create(:result, component:, external_id:) }
      let(:component) { existing_result.component }
      let(:external_id) { existing_result.external_id }

      describe "external_id uniqueness by component" do
        let(:existing_result) { create(:result, external_id: existing_result_external_id) }

        context "when the external_id is nil" do
          let(:existing_result_external_id) { nil }

          it "is valid" do
            expect { result.save! }.not_to raise_error
            expect(result.external_id).to be_nil
          end
        end

        context "when the external_id is empty" do
          let(:existing_result_external_id) { "" }

          it "is valid" do
            expect { result.save! }.not_to raise_error
            expect(result.external_id).to be_nil
          end
        end

        context "when the external_id has a value" do
          let(:existing_result_external_id) { "external-id" }

          it "is invalid" do
            expect { result.save! }.to raise_error(ActiveRecord::RecordNotUnique)
          end

          context "when the component is different" do
            let(:component) { create(:component, manifest_name: "accountability") }

            it "is valid" do
              expect { result.save! }.not_to raise_error
              expect(result.external_id).to eq(external_id)
            end
          end

          context "when the external_id is different" do
            let(:external_id) { "different-external-id" }

            it "is valid" do
              expect { result.save! }.not_to raise_error
              expect(result.external_id).to eq(external_id)
            end
          end
        end
      end
    end
  end
end

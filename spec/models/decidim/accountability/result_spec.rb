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

      describe ".ordered_by_position" do
        let(:component) { create(:accountability_component) }
        let!(:third) { create(:result, component:, position: 10, created_at: 3.days.ago) }
        let!(:first) { create(:result, component:, position: 1, created_at: 1.day.ago) }
        let!(:unpositioned_old) { create(:result, component:, position: nil, created_at: 2.days.ago) }
        let!(:unpositioned_new) { create(:result, component:, position: nil, created_at: 1.hour.ago) }
        let!(:second) { create(:result, component:, position: 5, created_at: 2.days.ago) }

        it "sorts by position ascending, unpositioned results last by creation date" do
          expect(Result.where(component:).ordered_by_position.to_a).to eq([first, second, third, unpositioned_old, unpositioned_new])
        end

        it "does not use the weight" do
          first.update!(weight: 0.9)
          third.update!(weight: 0.1)

          expect(Result.where(component:).ordered_by_position.first).to eq(first)
        end
      end

      describe ".ordered_by_position_grouped_by_parent" do
        let(:component) { create(:accountability_component) }
        let!(:second_parent) { create(:result, component:, position: 2) }
        let!(:first_parent) { create(:result, component:, position: 1) }
        let!(:unpositioned_parent) { create(:result, component:, position: nil) }
        let!(:second_parent_child) { create(:result, component:, parent: second_parent, position: 1) }
        let!(:first_parent_last_child) { create(:result, component:, parent: first_parent, position: 2) }
        let!(:first_parent_first_child) { create(:result, component:, parent: first_parent, position: 1) }
        let!(:unpositioned_parent_child) { create(:result, component:, parent: unpositioned_parent, position: 1) }

        it "lists each parent by position followed by its own children by position" do
          expect(Result.where(component:).ordered_by_position_grouped_by_parent.to_a).to eq(
            [
              first_parent, first_parent_first_child, first_parent_last_child,
              second_parent, second_parent_child,
              unpositioned_parent, unpositioned_parent_child
            ]
          )
        end
      end

      describe "#children" do
        let(:component) { create(:accountability_component) }
        let(:parent) { create(:result, component:) }
        let!(:last_child) { create(:result, component:, parent:, position: 3) }
        let!(:first_child) { create(:result, component:, parent:, position: 1) }
        let!(:middle_child) { create(:result, component:, parent:, position: 2) }

        it "returns the children ordered by position" do
          expect(parent.reload.children.to_a).to eq([first_child, middle_child, last_child])
        end
      end
    end
  end
end

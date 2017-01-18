require "spec_helper"

describe Decidim::Debates::DebateSearch do
  let(:current_feature) { create :feature }
  let(:scope1) { create :scope, organization: current_feature.organization }
  let(:scope2) { create :scope, organization: current_feature.organization }
  let!(:debate1) do
    create(
      :debate,
      feature: current_feature,
      start_time: 1.day.from_now,
      scope: scope1
    )
  end
  let!(:debate2) do
    create(
      :debate,
      feature: current_feature,
      start_time: 2.day.from_now,
      scope: scope2
    )
  end
  let(:external_debate) { create :debate }
  let(:feature_id) { current_feature.id }
  let(:organization_id) { current_feature.organization.id }
  let(:default_params) { { feature: current_feature } }
  let(:params) { default_params }

  subject { described_class.new(params) }

  describe "base query" do
    context "when no feature is passed" do
      let(:default_params) { { feature: nil } }

      it "raises an error" do
        expect{ subject.results }.to raise_error(StandardError, "Missing feature")
      end
    end
  end

  describe "filters" do
    context "feature_id" do
      it "only returns debates from the given feature" do
        external_debate = create(:debate)

        expect(subject.results).not_to include(external_debate)
      end
    end

    context "order_start_time" do
      let(:params) { default_params.merge(order_start_time: order) }

      context "is :asc" do
        let(:order) { :asc }

        it "sorts the debates by start_time asc" do
          expect(subject.results).to eq [debate1, debate2]
        end
      end

      context "is :desc" do
        let(:order) { :desc }

        it "sorts the debates by start_time desc" do
          expect(subject.results).to eq [debate2, debate1]
        end
      end
    end

    context "scope_id" do
      context "when a single id is being sent" do
        let(:params) { default_params.merge(scope_id: scope1.id) }

        it "filters debates by scope" do
          expect(subject.results).to eq [debate1]
        end
      end

      context "when multiple ids are sent" do
        let(:params) { default_params.merge(scope_id: [scope2.id, scope1.id]) }

        it "filters debates by scope" do
          expect(subject.results).to match_array [debate1, debate2]
        end
      end
    end
  end

  context "pagination" do
    let(:params) do
      default_params.merge(
        per_page: 2
      )
    end

    it "filters the debates per page" do
      create(:debate, feature: current_feature)
      debates = subject.results

      expect(debates.total_pages).to eq(2)
      expect(debates.total_count).to eq(3)
    end
  end
end

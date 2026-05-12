# frozen_string_literal: true

require "rails_helper"

describe CensusActionAuthorizer do
  subject { authorizer.authorize }

  let(:authorizer) { described_class.new(authorization, options, component, nil) }
  let(:organization) { create(:organization) }
  let(:user) { create(:user, organization:) }
  let(:component) { create(:component, organization:) }
  let(:authorization) { create(:authorization, :granted, name: "census_authorization_handler", user:, metadata:) }
  let(:options) { {} }
  let(:metadata) do
    {
      scope: "Ciutat Vella",
      scope_id: 1,
      scope_code: "1",
      postal_code: "08001",
      date_of_birth: "1987-09-17"
    }
  end

  describe "when no specific scopes are configured" do
    context "when user has census_authorization_handler authorization" do
      it "authorizes the user regardless of their scope" do
        expect(subject.first).to eq(:ok)
      end
    end

    context "when user has authorization with any scope" do
      let(:metadata) do
        {
          scope: "Eixample",
          scope_id: 2,
          scope_code: "2",
          postal_code: "08008",
          date_of_birth: "1987-09-17"
        }
      end

      it "authorizes the user regardless of their scope" do
        expect(subject.first).to eq(:ok)
      end
    end

    context "when user does not have census_authorization_handler authorization" do
      let(:authorization) { nil }

      it "does not authorize the user" do
        expect(subject.first).to eq(:missing)
      end
    end
  end

  describe "when specific scopes are configured" do
    context "when user has authorization with matching scope" do
      let(:options) do
        {
          "scope_code_1" => "1"
        }
      end

      let(:metadata) do
        {
          scope: "Ciutat Vella",
          scope_id: 1,
          scope_code: "1",
          postal_code: "08001",
          date_of_birth: "1987-09-17"
        }
      end

      it "authorizes the user" do
        expect(subject.first).to eq(:ok)
      end
    end

    context "when user has authorization with different scope" do
      let(:options) do
        {
          "scope_code_1" => "1"
        }
      end

      let(:metadata) do
        {
          scope: "Eixample",
          scope_id: 2,
          scope_code: "2",
          postal_code: "08008",
          date_of_birth: "1987-09-17"
        }
      end

      it "does not authorize the user" do
        expect(subject.first).to eq(:unauthorized)
      end

      it "includes extra explanation in the response" do
        expect(subject.last[:extra_explanation]).to be_present
      end
    end

    context "when user does not have authorization" do
      let(:authorization) { nil }
      let(:options) do
        {
          "scope_code_1" => "1"
        }
      end

      it "does not authorize the user" do
        expect(subject.first).to eq(:missing)
      end
    end

    context "when multiple scopes are configured" do
      let(:options) do
        {
          "scope_code_1" => "1",
          "scope_code_2" => "1"
        }
      end

      context "when user has authorization with one of the allowed scopes" do
        let(:metadata) do
          {
            scope: "Ciutat Vella",
            scope_id: 1,
            scope_code: "1",
            postal_code: "08001",
            date_of_birth: "1987-09-17"
          }
        end

        it "authorizes the user" do
          expect(subject.first).to eq(:ok)
        end
      end

      context "when user has authorization with another allowed scope" do
        let(:metadata) do
          {
            scope: "Eixample",
            scope_id: 2,
            scope_code: "2",
            postal_code: "08008",
            date_of_birth: "1987-09-17"
          }
        end

        it "authorizes the user" do
          expect(subject.first).to eq(:ok)
        end
      end

      context "when user has authorization with non-allowed scope" do
        let(:metadata) do
          {
            scope: "Sants-Montjuïc",
            scope_id: 3,
            scope_code: "3",
            postal_code: "08015",
            date_of_birth: "1987-09-17"
          }
        end

        it "does not authorize the user" do
          expect(subject.first).to eq(:unauthorized)
        end
      end
    end

    context "when scope option is configured but disabled" do
      let(:options) do
        {
          "scope_code_1" => "0"
        }
      end

      let(:metadata) do
        {
          scope: "Ciutat Vella",
          scope_id: 1,
          scope_code: "1",
          postal_code: "08001",
          date_of_birth: "1987-09-17"
        }
      end

      it "authorizes the user because no scopes are actually enabled" do
        expect(subject.first).to eq(:ok)
      end
    end

    context "when user authorization has no scope_code in metadata" do
      let(:options) do
        {
          "scope_code_1" => "1"
        }
      end

      let(:metadata) do
        {
          postal_code: "08001",
          date_of_birth: "1987-09-17"
        }
      end

      it "does not authorize the user" do
        expect(subject.first).to eq(:unauthorized)
      end
    end
  end

  describe "age restrictions" do
    let(:metadata) do
      {
        scope: "Ciutat Vella",
        scope_id: 1,
        scope_code: "1",
        postal_code: "08001",
        date_of_birth:
      }
    end
    let(:date_of_birth) { 30.years.ago.to_date.to_s }

    context "when no age options are configured" do
      let(:options) { {} }

      it "authorizes adults using the default minimum age" do
        expect(subject.first).to eq(:ok)
      end

      context "when the user is below the default minimum age" do
        let(:date_of_birth) { (CensusActionAuthorizer::DEFAULT_MIN_AGE - 1).years.ago.to_date.to_s }

        it "does not authorize the user" do
          expect(subject.first).to eq(:unauthorized)
        end

        it "includes the age extra explanation" do
          explanations = subject.last[:extra_explanation]
          expect(explanations).to be_present
          expect(explanations.first[:key]).to eq("age_extra_explanation")
          expect(explanations.first[:params][:min_age]).to eq(CensusActionAuthorizer::DEFAULT_MIN_AGE)
        end
      end
    end

    context "when min_age is configured" do
      let(:options) { { "min_age" => "18" } }

      context "when the user is at the minimum age" do
        let(:date_of_birth) { 18.years.ago.to_date.to_s }

        it "authorizes the user" do
          expect(subject.first).to eq(:ok)
        end
      end

      context "when the user is below the configured minimum age" do
        let(:date_of_birth) { 17.years.ago.to_date.to_s }

        it "does not authorize the user" do
          expect(subject.first).to eq(:unauthorized)
        end
      end

      context "when min_age is zero" do
        let(:options) { { "min_age" => "0" } }
        let(:date_of_birth) { 5.years.ago.to_date.to_s }

        it "treats zero as no minimum age and authorizes the user" do
          expect(subject.first).to eq(:ok)
        end
      end
    end

    context "when max_age is configured" do
      let(:options) { { "max_age" => "65" } }

      context "when the user is at the maximum age" do
        let(:date_of_birth) { 65.years.ago.to_date.to_s }

        it "authorizes the user" do
          expect(subject.first).to eq(:ok)
        end
      end

      context "when the user is above the configured maximum age" do
        let(:date_of_birth) { 70.years.ago.to_date.to_s }

        it "does not authorize the user" do
          expect(subject.first).to eq(:unauthorized)
        end

        it "uses the range explanation key" do
          explanations = subject.last[:extra_explanation]
          expect(explanations.first[:key]).to eq("age_extra_explanation_range")
          expect(explanations.first[:params][:max_age]).to eq(65)
        end
      end

      context "when max_age is zero" do
        let(:options) { { "max_age" => "0" } }
        let(:date_of_birth) { 80.years.ago.to_date.to_s }

        it "treats zero as no upper bound and authorizes the user" do
          expect(subject.first).to eq(:ok)
        end
      end
    end

    context "when both min_age and max_age are configured" do
      let(:options) { { "min_age" => "18", "max_age" => "65" } }

      context "when the user is within the range" do
        let(:date_of_birth) { 30.years.ago.to_date.to_s }

        it "authorizes the user" do
          expect(subject.first).to eq(:ok)
        end
      end

      context "when the user is below the minimum age" do
        let(:date_of_birth) { 17.years.ago.to_date.to_s }

        it "does not authorize the user" do
          expect(subject.first).to eq(:unauthorized)
        end
      end

      context "when the user is above the maximum age" do
        let(:date_of_birth) { 70.years.ago.to_date.to_s }

        it "does not authorize the user" do
          expect(subject.first).to eq(:unauthorized)
        end
      end
    end

    context "when age options are explicitly cleared in the admin form" do
      let(:options) { { "min_age" => "", "max_age" => "" } }
      let(:date_of_birth) { 5.years.ago.to_date.to_s }

      it "treats both as no restriction and authorizes the user" do
        expect(subject.first).to eq(:ok)
      end
    end

    context "when the authorization metadata has no date_of_birth" do
      let(:options) { {} }
      let(:metadata) do
        {
          scope: "Ciutat Vella",
          scope_id: 1,
          scope_code: "1",
          postal_code: "08001"
        }
      end

      it "does not authorize the user" do
        expect(subject.first).to eq(:unauthorized)
      end
    end
  end
end

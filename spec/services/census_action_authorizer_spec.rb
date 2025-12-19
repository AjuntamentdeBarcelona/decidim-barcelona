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
end

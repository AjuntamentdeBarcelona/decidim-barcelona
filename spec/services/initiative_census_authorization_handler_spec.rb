# frozen_string_literal: true

require "rails_helper"
require "decidim/dev/test/authorization_shared_examples"

describe InitiativeCensusAuthorizationHandler do
  subject { handler }

  let(:handler) { described_class.from_params(params) }
  let(:organization) { create(:organization) }
  let(:document_number) { "12345678A" }
  let(:document_type) { :nie }
  let(:postal_code) { "08001" }
  let(:date_of_birth) { Date.civil(1987, 9, 17) }
  let(:scope_id) { 123 }
  let(:scope_code) { "1" }
  let(:gender) { "foo" }
  let(:scope) { double(id: 999, code: scope_code, name: { "ca" => "Ciutat Vella" }) }
  let(:user) { create(:user, organization:) }
  let(:params) do
    {
      user:,
      document_number:,
      document_type:,
      postal_code:,
      scope_id:,
      gender:,
      date_of_birth:
    }
  end

  before do
    allow(Decidim::Scope).to receive(:find_by).and_return(scope)
    allow(handler)
      .to receive(:response)
      .and_return(Nokogiri::XML("<codiRetorn>01</codiRetorn>").remove_namespaces!)
  end

  it_behaves_like "an authorization handler"

  describe "#user_transferrable?" do
    context "when there is no duplicate" do
      it "returns falsey" do
        expect(handler).not_to be_user_transferrable
      end
    end

    context "when duplicate exists from another ephemeral user" do
      let!(:other_ephemeral_user) { create(:user, :ephemeral, organization:) }
      let!(:authorization) do
        create(:authorization,
               user: other_ephemeral_user,
               name: described_class.handler_name,
               unique_id: handler.unique_id)
      end

      context "when current user is ephemeral" do
        let(:user) { create(:user, :ephemeral, organization:) }

        it "returns true" do
          expect(handler.user_transferrable?).to be true
        end
      end

      context "when current user is registered" do
        it "returns falsey" do
          expect(handler).not_to be_user_transferrable
        end
      end
    end

    context "when duplicate exists from a registered user" do
      let!(:registered_user) { create(:user, :confirmed, organization:) }
      let!(:authorization) do
        create(:authorization,
               user: registered_user,
               name: described_class.handler_name,
               unique_id: handler.unique_id)
      end

      context "when current user is ephemeral" do
        let(:user) { create(:user, :ephemeral, organization:) }

        it "returns true (allows ephemeral to transfer to registered user)" do
          expect(handler.user_transferrable?).to be true
        end
      end

      context "when current user is registered" do
        it "returns falsey" do
          expect(handler).not_to be_user_transferrable
        end
      end
    end
  end

  describe "no conflict with regular census authorizations" do
    let!(:registered_user) { create(:user, :confirmed, organization:) }
    let!(:census_authorization) do
      create(:authorization,
             user: registered_user,
             name: "census_authorization_handler",
             unique_id: handler.unique_id)
    end

    it "does not find duplicates from census_authorization_handler" do
      expect(handler.duplicate).to be_nil
      expect(handler.unique?).to be true
    end
  end
end

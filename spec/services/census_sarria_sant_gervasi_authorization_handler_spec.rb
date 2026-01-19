# frozen_string_literal: true

require "rails_helper"
require "decidim/dev/test/authorization_shared_examples"
require "decidim/initiatives/test/factories"

describe CensusSarriaSantGervasiAuthorizationHandler do
  subject { handler }

  let(:handler) { described_class.from_params(params) }
  let(:document_number) { "12345678A" }
  let(:document_type) { :nie }
  let(:postal_code) { "08001" }
  let(:date_of_birth) { Date.civil(1987, 9, 17) }
  let(:scope_code) { "1" }
  let(:gender) { "foo" }
  let(:scope) { double(id: 5, code: scope_code, name: { "ca" => "Sarrià-Sant Gervasi" }) }
  let(:user) { create(:user) }
  let(:params) do
    {
      user:,
      document_number:,
      document_type:,
      postal_code:,
      scope_code:,
      gender:,
      date_of_birth:
    }
  end

  before do
    allow(Decidim::Scope).to receive(:find_by).and_return(scope)
  end

  it_behaves_like "an authorization handler"

  context "with a valid response" do
    before do
      allow(handler)
        .to receive(:response)
        .and_return(Nokogiri::XML("<codiRetorn>01</codiRetorn>").remove_namespaces!)
    end

    describe "document_number" do
      context "when it isn't present" do
        let(:document_number) { nil }

        it { is_expected.not_to be_valid }
      end

      context "with an invalid format" do
        let(:document_number) { "(╯°□°）╯︵ ┻━┻" }

        it { is_expected.not_to be_valid }
      end
    end

    describe "document_type" do
      context "when it isn't present" do
        let(:document_type) { nil }

        it { is_expected.not_to be_valid }
      end

      context "when it has a weird value" do
        let(:document_type) { :driver_license }

        it { is_expected.not_to be_valid }
      end
    end

    describe "postal_code" do
      context "when it isn't present" do
        let(:postal_code) { nil }

        it { is_expected.not_to be_valid }
      end

      context "when it has an invalid format" do
        let(:postal_code) { "(ヘ･_･)ヘ┳━┳" }

        it { is_expected.not_to be_valid }
      end

      context "when it doesn't belong to the district" do
        let(:postal_code) { "08035" }

        it { is_expected.not_to be_valid }
      end
    end

    describe "date_of_birth" do
      context "when it isn't present" do
        let(:date_of_birth) { nil }

        it { is_expected.not_to be_valid }
      end

      context "when data from a date field is provided" do
        let(:params) do
          {
            "date_of_birth(1i)" => "2010",
            "date_of_birth(2i)" => "8",
            "date_of_birth(3i)" => "16"
          }
        end

        let(:date_of_birth) { nil }

        it "correctly parses the date" do
          expect(subject.date_of_birth.year).to eq(2010)
          expect(subject.date_of_birth.month).to eq(8)
          expect(subject.date_of_birth.day).to eq(16)
        end
      end
    end

    context "when the scope is not from sarria sant gervasi" do
      let(:scope) { double(id: 6, code: scope_code, name: { "ca" => "Ciutat Vella" }) }

      before do
        allow(handler)
          .to receive(:response)
          .and_return(Nokogiri::XML("<codiRetorn>02</codiRetorn>").remove_namespaces!)
      end

      it { is_expected.not_to be_valid }
    end

    context "when everything is fine" do
      it { is_expected.to be_valid }
    end
  end

  context "when unique_id" do
    it "generates a different ID for a different document number" do
      handler.document_number = "ABC123"
      unique_id1 = handler.unique_id

      handler.document_number = "XYZ456"
      unique_id2 = handler.unique_id

      expect(unique_id1).not_to eq(unique_id2)
    end

    it "generates the same ID for the same document number" do
      handler.document_number = "ABC123"
      unique_id1 = handler.unique_id

      handler.document_number = "ABC123"
      unique_id2 = handler.unique_id

      expect(unique_id1).to eq(unique_id2)
    end

    it "hashes the document number" do
      handler.document_number = "ABC123"
      unique_id = handler.unique_id

      expect(unique_id).not_to include(handler.document_number)
    end
  end

  context "with an invalid response" do
    context "with a malformed response" do
      before do
        allow(handler)
          .to receive(:response)
          .and_return(Nokogiri::XML("Messed up response!").remove_namespaces!)
      end

      it { is_expected.not_to be_valid }
    end

    context "with an invalid response code" do
      before do
        allow(handler)
          .to receive(:response)
          .and_return(Nokogiri::XML("<codiRetorn>02</codiRetorn>").remove_namespaces!)
      end

      it { is_expected.not_to be_valid }
    end
  end

  describe "metadata" do
    it "includes the postal code" do
      expect(subject.metadata).to include(postal_code: "08001")
    end

    it "includes the scope name" do
      expect(subject.metadata).to include(scope: "Sarrià-Sant Gervasi")
    end

    it "includes the scope id" do
      expect(subject.metadata).to include(scope_id: scope.id)
    end

    it "includes the scope code" do
      expect(subject.metadata).to include(scope_code: scope.code)
    end

    it "includes the user gender" do
      expect(subject.metadata[:extras]).to include(gender:)
    end

    it "includes the date of birth" do
      expect(subject.metadata).to include(date_of_birth: date_of_birth&.strftime("%Y-%m-%d"))
    end
  end

  describe "initiative signature with extra params" do
    context "when check authorization with variation" do
      let(:organization) { create(:organization) }
      let(:initiatives_type) { create(:initiatives_type, organization:) }
      let(:initiative) { create(:initiative, organization:, scoped_type: create(:initiatives_type_scope, type: initiatives_type)) }
      let(:current_user) { create(:user, organization: initiative.organization) }
      let(:context) { { current_organization: organization } }
      let(:personal_data) do
        {
          name_and_surname: "James Morgan McGill",
          document_number: "01234567A",
          date_of_birth: 40.years.ago,
          postal_code: "87111"
        }
      end
      let(:vote_attributes) do
        {
          initiative:,
          author_id: current_user.id
        }
      end
      let(:attributes) { personal_data.merge(vote_attributes) }
      let(:form) { Decidim::Initiatives::LegacySignatureHandler.from_params(attributes).with_context(context) }
      let(:handler_name) { described_class.handler_name }
      let(:metadata) do
        {
          scope: scope.name["ca"],
          scope_id: scope.id,
          scope_code: scope.code,
          postal_code: form.postal_code,
          date_of_birth: form.date_of_birth&.strftime("%Y-%m-%d"),
          extras: {
            gender:
          }
        }
      end
      let(:authorization) do
        create(:authorization, created_at: Time.zone.today.prev_month, granted_at: Time.zone.today.prev_month, name: "name", user: current_user, metadata:)
      end
      let(:authorization_handler) do
        Decidim::AuthorizationHandler.handler_for(handler_name,
                                                  document_number: form.document_number,
                                                  name_and_surname: form.name_and_surname,
                                                  date_of_birth: form.date_of_birth,
                                                  postal_code: form.postal_code)
      end
      let(:authorization_handler_metadata_variations) do
        form.scope.children.map do |_child_scope|
          Decidim::AuthorizationHandler.handler_for(handler_name,
                                                    document_number: form.document_number,
                                                    name_and_surname: form.name_and_surname,
                                                    date_of_birth: form.date_of_birth,
                                                    postal_code: form.postal_code)
        end.unshift(authorization_handler).map(&:metadata)
      end
      let(:variation) { authorization_handler_metadata_variations.first }

      it "ignores extras field with all its content" do
        expect(authorization.metadata.symbolize_keys.except(:extras) == variation.symbolize_keys.except(:extras)).to be true
      end
    end
  end
end

# frozen_string_literal: true

require "rails_helper"

describe Decidim::ValidAuth::ValidAuthForm do
  subject do
    described_class.new(
      token: token,
      user: user
    )
  end

  let(:token) { "eyJhbGciOiJIUzI1NiJ9.eyJqdGkiOiIxL0FHc1hmaUY0bkFrSm04cGdmS1lhbGZHc2p2VkpUWU1OZlNTcFByRnIiLCJzdWIiOiJNQ0EiLCJpc3MiOiJBUlFfSU1JX0FKQkNOIiwiYXVkIjoiSU1JIiwiZXhwIjoxNTUxMzg2ODA0LCJyZWZyZXNoVG9rZW4iOiI0YW5GbnNmaFdoRDJ6SHcyb1FrVkNvWUtMRmt0REFEVWN6MHVUenNNIiwidGltZXN0YW1wIjoxNTUxMTcwODY0MjM0LCJpZGVudGlmaWVyIjoiMDAwMDAwMDBaIiwibWV0aG9kIjoiY2VydGlmaWNhdCIsInByZWZpeCI6IjAwMzQiLCJuYW1lIjoiSk9ITiIsImFzc3VyYW5jZUxldmVsIjoic3Vic3RhbnRpYWwiLCJpZGVudGlmaWVyVHlwZSI6IjEiLCJzdXJuYW1lcyI6IkRPRSIsInN0YXR1cyI6Im9rIiwiY2VydGlmaWNhdGVUeXBlIjoiMCJ9.jZkp-5hR6g2wFlUT3IbNHOZl3CgL7EWhqqqOCcS6Bp4" }
  let(:user) { create(:user, :confirmed) }

  context "when everything is OK" do
    it { is_expected.to be_valid }

    describe "metadata" do
      it "includes the certificate data" do
        expect(subject.metadata).to include(assurance_level: kind_of(String))
        expect(subject.metadata).to include(certificate_type: kind_of(String))
        expect(subject.metadata).to include(method: kind_of(String))
      end
    end

    it "sets the user data as the unique_id" do
      other_user = create(:user, organization: user.organization)
      create(:authorization, name: subject.handler_name, user: other_user, unique_id: subject.unique_id)

      expect(subject).to be_invalid
      expect(subject.errors[:base]).to eq(["A user is already authorized with the same data."])
    end
  end

  describe "validations" do
    context "without the correct sub" do
      before do
        allow(subject).to receive(:token_sub).and_return("foo")
      end

      it { is_expected.to be_invalid }
    end

    context "without the correct iss" do
      before do
        allow(subject).to receive(:token_iss).and_return("foo")
      end

      it { is_expected.to be_invalid }
    end

    context "without the correct aud" do
      before do
        allow(subject).to receive(:token_aud).and_return("foo")
      end

      it { is_expected.to be_invalid }
    end

    context "without the correct status" do
      before do
        allow(subject).to receive(:token_status).and_return("foo")
      end

      it { is_expected.to be_invalid }
    end
  end
end
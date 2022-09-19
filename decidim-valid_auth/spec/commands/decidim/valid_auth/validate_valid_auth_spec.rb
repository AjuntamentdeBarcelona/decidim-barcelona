# frozen_string_literal: true

require "rails_helper"

describe Decidim::ValidAuth::ValidateValidAuth do
  subject do
    described_class.new(
      authorization,
      handler
    )
  end

  let(:handler) { Decidim::ValidAuth::ValidAuthForm.new(token: token, user: user) }
  let(:token) { generate(:valid_jwt) }
  let(:user) { create(:user, :confirmed) }

  let(:authorization) do
    build(:authorization, :pending, user: user, name: handler.handler_name)
  end

  context "when everything is OK" do
    it "broadcasts ok" do
      expect { subject.call }.to broadcast(:ok)
    end

    it "updates the authorization for the user" do
      expect { subject.call }.to change(Decidim::Authorization, :count).by(1)
    end

    it "grants the authorization" do
      subject.call
      authorization = Decidim::Authorization.find_by(user: user, name: handler.handler_name)

      expect(authorization).to be_granted
    end
  end

  context "when there's an error in the token" do
    before do
      allow(handler).to receive(:valid?).and_return(false)
    end

    it "broadcasts invalid" do
      expect { subject.call }.to broadcast(:invalid)
    end

    it "doesn't update the authorization for the user" do
      expect { subject.call }.not_to change(Decidim::Authorization, :count)
    end
  end
end

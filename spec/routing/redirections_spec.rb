require "rails_helper"
require "decidim/dev/test/spec_helper"
require "decidim/core/test/factories"
require "decidim/proposals/test/factories"

describe "routing redirections", type: :request do
  let!(:organization) { create(:organization, host: "decidim.barcelona" )}

  describe "proposals" do
    let!(:participatory_process) { create(:participatory_process, organization: organization, slug: "test-process") }
    let!(:feature) { create(:proposal_feature, participatory_process: participatory_process) }
    let!(:proposal) { create(:proposal, feature: feature, extra: { slug: "test-proposal" }) }

    context "with the right host" do
      before(:each) do
        host! organization.host
      end

      it "redirects top-level proposals" do
        expect(get("/proposals/test-proposal"))
          .to redirect_to("/processes/#{participatory_process.id}/f/#{feature.id}/proposals/#{proposal.id}")
      end

      it "redirects proposals inside the old step structure" do
        expect(get("/test-process/123/proposals/test-proposal"))
          .to redirect_to("/processes/#{participatory_process.id}/f/#{feature.id}/proposals/#{proposal.id}")
      end

      it "redirects index paths inside the old step structure" do
        expect(get("/test-process/123/proposals/"))
          .to redirect_to("/processes/#{participatory_process.id}/f/#{feature.id}")
      end
    end

    context "with the wrong host" do
      before(:each) do
        host! "foo.bar"
      end

      it "doesn't redirect" do
        expect { get("/proposals/test-proposal") }.to raise_error(ActionController::RoutingError)
      end
    end
  end
end

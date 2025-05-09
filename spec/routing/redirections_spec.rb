# frozen_string_literal: true

require "rails_helper"
require "decidim/dev/test/spec_helper"
require "decidim/core/test/factories"
require "decidim/assemblies/test/factories"
require "decidim/participatory_processes/test/factories"
require "decidim/proposals/test/factories"
require "decidim/meetings/test/factories"
require "decidim/debates/test/factories"
require "decidim/accountability/test/factories"

describe "routing redirections", type: :request do
  let(:organization) { create(:organization, host: "decidim.barcelona", available_authorizations: authorizations) }
  let(:authorizations) { %w(dummy_authorization_handler another_dummy_authorization_handler) }

  describe "debates" do
    let(:participatory_space) { create(:participatory_process, organization:, slug: "test-process") }
    let(:component) { create(:debates_component, participatory_space:) }
    let!(:debate) { create(:debate, component:, extra: { slug: "test-debate" }) }

    context "with the right host" do
      before do
        host! organization.host
      end

      it "redirects top-level debates" do
        expect(get("/debates/test-debate"))
          .to redirect_to("/processes/#{participatory_space.slug}/f/#{component.id}/debates/#{debate.id}")
      end

      it "redirects debates inside the old structure without step ID" do
        expect(get("/test-process/debates/test-debate"))
          .to redirect_to("/processes/#{participatory_space.slug}/f/#{component.id}/debates/#{debate.id}")
      end

      it "redirects debates inside the old structure without step ID using debate id" do
        expect(get("/test-process/debates/#{debate.id}"))
          .to redirect_to("/processes/#{participatory_space.slug}/f/#{component.id}/debates/#{debate.id}")
      end

      it "redirects debates inside the old step structure" do
        expect(get("/test-process/123/debates/test-debate"))
          .to redirect_to("/processes/#{participatory_space.slug}/f/#{component.id}/debates/#{debate.id}")
      end

      it "redirects debates inside the old step structure using debate id" do
        expect(get("/test-process/123/debates/#{debate.id}"))
          .to redirect_to("/processes/#{participatory_space.slug}/f/#{component.id}/debates/#{debate.id}")
      end

      it "redirects index paths inside the old step structure" do
        expect(get("/test-process/123/debates/"))
          .to redirect_to("/processes/#{participatory_space.slug}/f/#{component.id}")
      end
    end

    context "with the wrong host" do
      before do
        host! "foo.bar"
      end

      it "doesn't redirect" do
        expect { get("/debates/test-debate") }.to raise_error(ActionController::RoutingError)
      end
    end
  end

  describe "accountability" do
    let(:participatory_space) { create(:participatory_process, organization:, slug: "test-process") }
    let(:component) { create(:accountability_component, participatory_space:) }
    let!(:result) { create(:result, component:) }

    context "with the right host" do
      before do
        host! organization.host
      end

      it "redirects top-level accountability result" do
        expect(get("/action_plans/#{result.id}"))
          .to redirect_to("/processes/#{participatory_space.slug}/f/#{component.id}/results/#{result.id}")
      end

      it "redirects accountability results inside the old structure without step ID" do
        expect(get("/test-process/action_plans/#{result.id}"))
          .to redirect_to("/processes/#{participatory_space.slug}/f/#{component.id}/results/#{result.id}")
      end

      it "redirects accountability results inside the old step structure" do
        expect(get("/test-process/123/action_plans/#{result.id}"))
          .to redirect_to("/processes/#{participatory_space.slug}/f/#{component.id}/results/#{result.id}")
      end

      it "redirects index paths inside the old step structure" do
        expect(get("/test-process/123/action_plans/"))
          .to redirect_to("/processes/#{participatory_space.slug}/f/#{component.id}")
      end
    end

    context "with the wrong host" do
      before do
        host! "foo.bar"
      end

      it "doesn't redirect" do
        expect { get("/action_plans/test-result") }.to raise_error(ActionController::RoutingError)
      end
    end
  end

  describe "proposals" do
    let(:participatory_process) { create(:participatory_process, organization:, slug: "test-process") }
    let(:component) { create(:proposal_component, participatory_space: participatory_process) }
    let!(:proposal) { create(:proposal, component:, extra: { slug: "test-proposal" }) }

    context "with the right host" do
      before do
        host! organization.host
      end

      it "redirects top-level proposals" do
        expect(get("/proposals/test-proposal"))
          .to redirect_to("/processes/#{participatory_process.slug}/f/#{component.id}/proposals/#{proposal.id}")
      end

      it "redirects proposals inside the old structure without step ID" do
        expect(get("/test-process/proposals/test-proposal"))
          .to redirect_to("/processes/#{participatory_process.slug}/f/#{component.id}/proposals/#{proposal.id}")
      end

      it "redirects proposals inside the old step structure" do
        expect(get("/test-process/123/proposals/test-proposal"))
          .to redirect_to("/processes/#{participatory_process.slug}/f/#{component.id}/proposals/#{proposal.id}")
      end

      it "redirects index paths inside the old step structure" do
        expect(get("/test-process/123/proposals/"))
          .to redirect_to("/processes/#{participatory_process.slug}/f/#{component.id}")
      end
    end

    context "with the wrong host" do
      before do
        host! "foo.bar"
      end

      it "doesn't redirect" do
        expect { get("/proposals/test-proposal") }.to raise_error(ActionController::RoutingError)
      end
    end
  end

  describe "meetings" do
    let(:participatory_space) { create(:assembly, organization:, slug: "test-assembly") }
    let!(:component) { create(:meeting_component, participatory_space:) }
    let(:meeting) { create(:meeting, component:) }

    context "with the right host" do
      before do
        host! organization.host
      end

      it "does not redirect when paginating the meetings directory" do
        expect { get("/meetings/meetings?page=2") }.not_to raise_error
      end

      context "when browsing the meetings of an assembly" do
        it "does not try to redirect" do
          expect { get("/assemblies/#{participatory_space.slug}/f/#{component.id}/meetings/#{meeting.id}") }.not_to raise_error
        end
      end

      context "when browsing the meetings of a process" do
        let!(:participatory_space) { create(:participatory_process, organization:, slug: "test-process") }

        it "does not try to redirect" do
          expect { get("/processes/#{participatory_space.slug}/f/#{component.id}/meetings/#{meeting.id}") }.not_to raise_error
        end
      end
    end
  end
end

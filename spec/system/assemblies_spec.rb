# frozen_string_literal: true

require "rails_helper"

describe "Assemblies" do
  let(:organization) { create(:organization) }

  before do
    switch_to_host(organization.host)
  end

  context "when there are some published assemblies" do
    let(:number_of_assemblies) { 30 }
    let!(:assemblies) { create_list(:assembly, number_of_assemblies, organization:) }

    context "and requesting the assemblies path" do
      before do
        visit decidim_assemblies.assemblies_path
      end

      it "lists 25 assemblies per page" do
        within "#assemblies-grid" do
          expect(page).to have_css("[id^=assembly_]", count: 25)
        end
      end
    end
  end
end

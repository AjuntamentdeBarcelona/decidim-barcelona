# frozen_string_literal: true

require "rails_helper"

describe "Assemblies" do
  let(:organization) do
    create(
      :organization,
      name: "Ajuntament",
      default_locale: :ca,
      available_locales: [:es, :ca]
    )
  end

  before do
    switch_to_host(organization.host)
  end

  context "when there are some published assemblies" do
    let(:number_of_assemblies) { 25 }
    let!(:assemblies) { create_list(:assembly, number_of_assemblies, organization:) }

    context "and requesting the assemblies path" do
      before do
        visit decidim_assemblies.assemblies_path
      end

      it "lists 20 assemblies per page" do
        within "#assemblies-grid" do
          expect(page).to have_content("Resultats per pàgina:\n20")
          expect(page).to have_css("[id^=assembly_]", count: 20)
        end
      end
    end
  end
end

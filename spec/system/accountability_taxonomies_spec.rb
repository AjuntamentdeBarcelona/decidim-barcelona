# frozen_string_literal: true

require "rails_helper"
require "decidim/accountability/test/factories"
require "decidim/participatory_processes/test/factories"

describe "Accountability taxonomies" do
  let(:organization) { create(:organization, available_locales: [:ca], default_locale: :ca) }
  let(:participatory_process) { create(:participatory_process, :published, organization:) }
  let(:component) { create(:accountability_component, :published, participatory_space: participatory_process) }

  # Same shape the categories migration left behind: root -> per-space node -> categories,
  # with only the categories (and subcategories) added as filter items.
  let(:root_taxonomy) { create(:taxonomy, organization:, name: { ca: "Categories" }) }
  let(:space_taxonomy) { create(:taxonomy, parent: root_taxonomy, organization:, name: { ca: "Procés participatiu: Pressupostos" }) }
  let(:category) { create(:taxonomy, parent: space_taxonomy, organization:, name: { ca: "Verd urbà" }) }
  let(:other_category) { create(:taxonomy, parent: space_taxonomy, organization:, name: { ca: "Equipaments municipals" }) }
  let(:subcategory) { create(:taxonomy, parent: category, organization:, name: { ca: "Parcs i jardins" }) }
  let(:taxonomy_filter) { create(:taxonomy_filter, root_taxonomy:) }
  let(:filter_items) { [category, other_category, subcategory] }
  let(:result_taxonomies) { [subcategory, other_category] }

  before do
    filter_items.each { |taxonomy_item| create(:taxonomy_filter_item, taxonomy_filter:, taxonomy_item:) }
    component.update!(settings: { taxonomy_filters: [taxonomy_filter.id] })
    result_taxonomies.each { |taxonomy| create(:result, component:, taxonomies: [taxonomy]) }

    switch_to_host(organization.host)
    visit Decidim::EngineRouter.main_proxy(component).root_path(root_taxonomy_id: root_taxonomy.id)
  end

  context "when the categories have subcategories" do
    it "shows the categories with their subcategories" do
      within ".accountability__grid--two-levels" do
        expect(page).to have_content("Verd urbà")
        expect(page).to have_content("Equipaments municipals")
        expect(page).to have_content("Parcs i jardins")
        expect(page).to have_no_content("Procés participatiu: Pressupostos")
      end
    end
  end

  context "when the categories have no subcategories" do
    let(:filter_items) { [category, other_category] }
    let(:result_taxonomies) { [category, other_category] }

    it "shows the categories in one level" do
      within ".accountability__grid--one-level" do
        expect(page).to have_content("Verd urbà")
        expect(page).to have_content("Equipaments municipals")
        expect(page).to have_no_content("Procés participatiu: Pressupostos")
      end
    end
  end

  context "when the root has direct children available" do
    let(:filter_items) { [space_taxonomy, category] }
    let(:result_taxonomies) { [category] }

    it "keeps the default behavior" do
      within ".accountability__grid--two-levels" do
        expect(page).to have_content("Procés participatiu: Pressupostos")
        expect(page).to have_content("Verd urbà")
      end
    end
  end
end

# frozen_string_literal: true

require "rails_helper"
require "decidim/accountability/test/factories"
require "decidim/participatory_processes/test/factories"

describe "Accountability results ordered by position" do
  let(:organization) { create(:organization, available_locales: [:ca], default_locale: :ca) }
  let(:participatory_process) { create(:participatory_process, :published, organization:) }
  let(:component) { create(:accountability_component, :published, participatory_space: participatory_process) }

  let!(:third) { create(:result, component:, position: 30, title: { ca: "Result Gamma" }, created_at: 3.days.ago) }
  let!(:first) { create(:result, component:, position: 10, title: { ca: "Result Alpha" }, created_at: 1.day.ago) }
  let!(:unpositioned) { create(:result, component:, position: nil, title: { ca: "Result Omega" }, created_at: 4.days.ago) }
  let!(:second) { create(:result, component:, position: 20, title: { ca: "Result Beta" }, created_at: 2.days.ago) }

  before do
    switch_to_host(organization.host)
  end

  def expect_order(container, *titles)
    text = find(container).text
    positions = titles.map { |title| text.index(title) }
    expect(positions).to all(be_present), "expected #{titles} within #{container}, got: #{text}"
    expect(positions).to eq(positions.sort)
  end

  describe "public results list" do
    it "shows the results by position, unpositioned last" do
      visit Decidim::EngineRouter.main_proxy(component).results_path

      expect_order("#results", "Result Alpha", "Result Beta", "Result Gamma", "Result Omega")
    end

    context "when results have sub-results" do
      let!(:beta_child) { create(:result, component:, parent: second, position: 1, title: { ca: "Child of Beta" }) }
      let!(:alpha_last_child) { create(:result, component:, parent: first, position: 2, title: { ca: "Child Zulu" }) }
      let!(:alpha_first_child) { create(:result, component:, parent: first, position: 1, title: { ca: "Child Yankee" }) }

      it "lists each result followed by its own sub-results" do
        visit Decidim::EngineRouter.main_proxy(component).results_path

        expect_order("#results", "Result Alpha", "Child Yankee", "Child Zulu", "Result Beta", "Child of Beta", "Result Gamma", "Result Omega")
      end
    end
  end

  describe "sub-results of a result" do
    let!(:last_child) { create(:result, component:, parent: first, position: 2, title: { ca: "Child Zulu" }) }
    let!(:first_child) { create(:result, component:, parent: first, position: 1, title: { ca: "Child Yankee" }) }

    it "shows the sub-results by position" do
      visit Decidim::EngineRouter.main_proxy(component).result_path(first)

      expect_order("#panel-included_results", "Child Yankee", "Child Zulu")
    end
  end

  describe "admin results list" do
    let(:user) { create(:user, :admin, :confirmed, organization:) }

    before do
      login_as user, scope: :user
    end

    it "shows the results by position, unpositioned last" do
      visit Decidim::EngineRouter.admin_proxy(component).results_path

      expect_order("table tbody", "Result Alpha", "Result Beta", "Result Gamma", "Result Omega")
    end

    it "lets the admin set the position with the new labels" do
      visit Decidim::EngineRouter.admin_proxy(component).edit_result_path(unpositioned)

      expect(page).to have_field("Ordre de posició")
      expect(page).to have_field("Ponderació", with: "1.0")
      expect(page).to have_content("S'ordena de menor a major")

      fill_in "Ordre de posició", with: "5"
      click_on "Actualitzar"

      expect(page).to have_admin_callout("Resultat actualitzat correctament.")
      expect(unpositioned.reload.position).to eq(5)

      visit Decidim::EngineRouter.main_proxy(component).results_path
      expect_order("#results", "Result Omega", "Result Alpha", "Result Beta", "Result Gamma")
    end
  end
end

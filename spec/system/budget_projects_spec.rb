# frozen_string_literal: true

require "rails_helper"

describe "Budget projects" do
  let(:organization) do
    create(
      :organization,
      available_locales: [:en],
      default_locale: :en
    )
  end
  let(:participatory_process) { create(:participatory_process, :with_steps, organization:) }
  let(:component) { create(:budgets_component, participatory_space: participatory_process) }
  let(:budget) { create(:budget, component:) }
  let!(:project) { create(:project, budget:) }

  before do
    switch_to_host(organization.host)
  end

  context "when voting is open (focus mode)" do
    it "renders the projects list with the focus mode header" do
      visit Decidim::EngineRouter.main_proxy(component).budget_projects_path(budget_id: budget.id)

      expect(page).to have_content(translated(project.title))
      expect(page).to have_css(".main-bar--focus-mode-back-button")
    end
  end

  context "when voting is disabled" do
    let(:component) { create(:budgets_component, :with_votes_disabled, participatory_space: participatory_process) }

    it "renders the projects list with the regular header" do
      visit Decidim::EngineRouter.main_proxy(component).budget_projects_path(budget_id: budget.id)

      expect(page).to have_content(translated(project.title))
      expect(page).to have_css(".main-bar__logo")
    end
  end
end

require "spec_helper"

describe "Explore debates", type: :feature do
  let(:organization) { create(:organization) }
  let(:participatory_process) { create(:participatory_process, organization: organization) }
  let(:current_feature) { create :feature, participatory_process: participatory_process, manifest_name: "debates" }
  let(:debates_count) { 5 }
  let!(:debates) do
    create_list(
      :debate,
      debates_count,
      feature: current_feature,
      start_time: DateTime.new(2016, 12, 13, 14, 15),
      end_time: DateTime.new(2016, 12, 13, 16, 17)
    )
  end

  before do
    switch_to_host(organization.host)
    visit path
  end

  context "index" do
    let(:path) { decidim_debates.debates_path(participatory_process_id: participatory_process.id, feature_id: current_feature.id) }

    it "shows all debates for the given process" do
      expect(page).to have_selector("article.card", count: debates_count)

      debates.each do |debate|
        expect(page).to have_content(translated debate.title)
      end
    end
  end

  context "show" do
    let(:path) { decidim_debates.debate_path(id: debate.id, participatory_process_id: participatory_process.id, feature_id: current_feature.id) }
    let(:debates_count) { 1 }
    let(:debate) { debates.first }

    it "shows all debate info" do
      expect(page).to have_i18n_content(debate.title)
      expect(page).to have_i18n_content(debate.description)
      expect(page).to have_i18n_content(debate.short_description)
      expect(page).to have_i18n_content(debate.location)
      expect(page).to have_i18n_content(debate.location_hints)
      expect(page).to have_content(debate.address)

      within ".section.view-side" do
        expect(page).to have_content(13)
        expect(page).to have_content(/December/i)
        expect(page).to have_content("14:15 - 16:17")
      end
    end

    context "without category or scope" do
      it "does not show any tag" do
        expect(page).not_to have_selector("ul.tags.tags--debate")
      end
    end

    context "with a category" do
      let(:debate) do
        debate = debates.first
        debate.category = create :category, participatory_process: participatory_process
        debate.save
        debate
      end

      it "shows tags for category" do
        expect(page).to have_selector("ul.tags.tags--debate")
        within "ul.tags.tags--debate" do
          expect(page).to have_content(translated(debate.category.name))
        end
      end

      it "links to the filter for this category" do
        within "ul.tags.tags--debate" do
          click_link translated(debate.category.name)
        end
        expect(page).to have_select("filter_category_id", selected: translated(debate.category.name))
      end
    end

    context "with a scope" do
      let(:debate) do
        debate = debates.first
        debate.scope = create :scope, organization: organization
        debate.save
        debate
      end

      it "shows tags for scope" do
        expect(page).to have_selector("ul.tags.tags--debate")
        within "ul.tags.tags--debate" do
          expect(page).to have_content(debate.scope.name)
        end
      end

      it "links to the filter for this scope" do
        within "ul.tags.tags--debate" do
          click_link debate.scope.name
        end
        expect(page).to have_checked_field(debate.scope.name)
      end
    end
  end
end

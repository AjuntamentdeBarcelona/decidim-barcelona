# frozen_string_literal: true

require "rails_helper"

describe "Overrides" do
  scenario "remove override to fix created debates notifications" do
    # remove lib/decidim/events/author_event.rb after https://github.com/decidim/decidim/issues/6091 is fixed
    expect(Decidim.version).to be < "0.22"
  end

  scenario "remove override to fix incorrect organization time zone" do
    # remove app/controllers/decidim/api/application_controller.rb after https://github.com/decidim/decidim/pull/6088 is merged
    expect(Decidim.version).to be < "0.22"
  end

  scenario "remove detroy meeting related translations" do
    # remove :ca and :es entries for:
    # - decidim.meetings.actions.invalid_destroy.proposals_count.one
    # - decidim.meetings.actions.invalid_destroy.proposals_count.other
    # - decidim.meetings.admin.meetings.destroy.invalid.proposals_count.one
    # - decidim.meetings.admin.meetings.destroy.invalid.proposals_count.other
    expect(Decidim.version).to be < "0.22"
  end

  it "remove consistent sorting of proposal attachments" do
    # remove app/overrides/cells/decidim/proposals/proposal_m_cell_decorator.rb
    expect(Decidim.version).to be < "0.24"
  end
end

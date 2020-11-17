# frozen_string_literal: true

require "rails_helper"

describe "Overrides" do
  it "remove consistent sorting of proposal attachments" do
    # remove app/overrides/cells/decidim/proposals/proposal_m_cell_decorator.rb
    expect(Decidim.version).to be < "0.24"
  end

  it "remove: Fix accept invitation to private meetings" do
    # remove app/overrides/controllers/decidim/meetings/registrations_controller_decorator.rb
    # remove app/overrides/models/decidim/meetings/meeting_decorator.rb
    # remove app/overrides/permissions/decidim/meetings/permissions_decorator.rb
    # app/overrides/cells/decidim/meetings/highlighted_meetings_for_component_cell_decorator.rb
    expect(Decidim.version).to be < "0.22"
  end

  it "remove: Fix accept invitation to private meetings" do
    # app/overrides/cells/decidim/meetings/upcoming_events_cell_decorator.rb
    expect(Decidim.version).to be < "0.23"
  end
end

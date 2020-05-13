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
end

# frozen_string_literal: true

require "rails_helper"

describe "Overrides" do
  it "remove consistent sorting of proposal attachments" do
    # remove app/overrides/cells/decidim/proposals/proposal_m_cell_decorator.rb
    expect(Decidim.version).to be < "0.24"
  end

  it "fix how the stats module retrieves users" do
    # check Performers in decidim-stats.
    #
    # They no longer can query Authorizations directly because the  metadata`
    # field is now encrypted. We need to load of all them and filter in Ruby
    # side.
    expect(Decidim.version).to be < "0.24"
  end
end

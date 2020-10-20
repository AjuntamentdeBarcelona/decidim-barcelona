# frozen_string_literal: true

require "rails_helper"

describe "Overrides" do
  it "remove consistent sorting of proposal attachments" do
    # remove app/overrides/cells/decidim/proposals/proposal_m_cell_decorator.rb
    expect(Decidim.version).to be < "0.24"
  end
end

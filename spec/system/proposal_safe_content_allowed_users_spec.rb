# frozen_string_literal: true

require "rails_helper"

describe "Proposal safe content allowed users", :perform_enqueued do
  include_context "with a component"
  let(:manifest_name) { "proposals" }

  let!(:proposal) { create(:proposal, :participant_author, skip_injection: true, component:, body: { "en" => body }) }
  let(:proposal_title) { translated(proposal.title) }
  let(:body) do
    <<~HTML.strip
      <p><img src="/path/to/image.jpg" alt="Image"></p>
      <div class="editor-content-videoEmbed">
        <div>
          <iframe src="https://example.org/video/xyz" title="Video" frameborder="0" allowfullscreen="true"></iframe>
        </div>
      </div>
    HTML
  end
  let(:allowed_users) { "" }

  let(:organization) do
    create(
      :organization,
      default_locale: :en,
      available_locales: [:en]
    )
  end

  before do
    ENV["PROPOSAL_SAFE_CONTENT_ALLOWED_USERS"] = allowed_users
    data_consent(true, visit_root: true)
    visit_component
    click_on proposal_title
  end

  context "without allowed user" do
    it "doesn't render the image neither the iframe embed" do
      expect(page).to have_no_css(".rich-text-display img[src='/path/to/image.jpg']")
      expect(page).to have_no_css(".editor-content-videoEmbed iframe[src='https://example.org/video/xyz']")
    end
  end

  context "with allowed user" do
    let(:allowed_users) { proposal.authors.first.id.to_s }

    it "renders the image and iframe embed" do
      expect(page).to have_css(".rich-text-display img[src='/path/to/image.jpg']")
      expect(page).to have_css(".editor-content-videoEmbed iframe[src='https://example.org/video/xyz']")
    end
  end
end

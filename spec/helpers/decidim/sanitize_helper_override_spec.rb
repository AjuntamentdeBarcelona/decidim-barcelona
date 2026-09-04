# frozen_string_literal: true

require "rails_helper"

module Decidim
  describe SanitizeHelper do
    context "when html_escape is invoked" do
      let(:user_input) { "Accessibilitat, inclusió i igualtat d'oportunitats <script>alert(\"XSS\")</script>" }

      it "escapes the HTML special characters" do
        expect(helper.decidim_html_escape(user_input)).to eq(
          "Accessibilitat, inclusió i igualtat d&#39;oportunitats &lt;script&gt;alert(&quot;XSS&quot;)&lt;/script&gt;"
        )
      end

      it "returns an HTML-safe string so it is not escaped again when rendered" do
        escaped = helper.decidim_html_escape(user_input)

        expect(escaped).to be_html_safe
        expect(helper.content_tag(:span, escaped)).to eq(
          "<span>Accessibilitat, inclusió i igualtat d&#39;oportunitats &lt;script&gt;alert(&quot;XSS&quot;)&lt;/script&gt;</span>"
        )
      end

      it "escapes the content even when the input is marked as HTML-safe" do
        escaped = helper.decidim_html_escape("<b>d'oportunitats</b>".html_safe)

        expect(escaped).to eq("&lt;b&gt;d&#39;oportunitats&lt;/b&gt;")
        expect(escaped).to be_html_safe
      end
    end

    context "when escape_translated is invoked" do
      let(:user_input) { { "ca" => "Igualtat d'oportunitats", "en" => "Equal opportunities" } }

      it "escapes the translated value and returns an HTML-safe string" do
        I18n.with_locale(:ca) do
          expect(helper.decidim_escape_translated(user_input)).to eq("Igualtat d&#39;oportunitats")
          expect(helper.decidim_escape_translated(user_input)).to be_html_safe
        end
      end
    end
  end
end

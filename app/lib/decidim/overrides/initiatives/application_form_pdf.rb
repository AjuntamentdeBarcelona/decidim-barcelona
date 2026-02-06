# frozen_string_literal: true

module Decidim
  module Overrides
    module Initiatives
      module ApplicationFormPdf
        BACKGROUND_GREY = "DDDDDD"
        BORDER_WIDTH = 0.5
        CELL_PADDING = [5, 5, 5, 5].freeze

        def composer
          @composer ||= begin
            c = ::HexaPDF::Composer.new
            # Replace missing glyphs with a space instead of raising an error
            # This handles special Unicode characters not present in Source Sans Pro
            c.document.config["font.on_missing_glyph"] = lambda do |_codepoint, font_wrapper|
              font_wrapper.glyph(0x20)
            end
            c
          end
        end

        def render
          composer.styles(**styles)

          add_header
          add_title_section
          add_reference_table
          add_title_box
          add_metadata_table
          add_content_boxes

          composer.new_page
          add_header
          add_authorship_section
          add_committee_section
          add_date_section
          add_legal_box

          composer.write_to_string
        end

        private

        def styles
          {
            pdf_main_title: { font: bold_font, text_align: :center, font_size: 16, margin: [15, 0, 20, 0] },
            section_title: { font: bold_font, text_align: :left, font_size: 12, margin: [15, 0, 5, 0] },
            table_header: { font: bold_font, text_align: :left, font_size: 11 },
            table_value: { font:, text_align: :left, font_size: 11 }
          }
        end

        def i18n_scope
          "decidim.initiatives.initiatives.print"
        end

        def t(key)
          I18n.t(key, scope: i18n_scope)
        end

        def header_cell(label, padding: [3, 5, 3, 5])
          { content: layout.text(label, style: :table_header), padding: padding }
        end

        def value_cell(value, col_span: nil)
          cell = {
            content: layout.text(value.to_s, style: :table_value),
            padding: CELL_PADDING,
            background_color: BACKGROUND_GREY
          }
          cell[:col_span] = col_span if col_span
          cell
        end

        def default_table_style
          { cell_style: { border: { width: BORDER_WIDTH } }, style: { margin: [0, 0, 8, 0] } }
        end

        def add_header
          left_logo = document.images.add(Rails.root.join("app/packs/images/logo-ajbcn.png").to_s)
          right_logo = document.images.add(Rails.root.join("app/packs/images/decidim-bcn-logo.png").to_s)

          cells = [
            { content: layout.image(left_logo, width: 130, height: 27), padding: 0 },
            { content: layout.text(""), padding: 0 },
            { content: layout.image(right_logo, width: 60, height: 60), padding: 0 }
          ]

          composer.table([cells], column_widths: [150, -1, 80], cell_style: { border: { width: 0 }, padding: [0, 0, 15, 0] })
        end

        def add_title_section
          composer.text(t("pdf_title"), style: :pdf_main_title)
        end

        def add_reference_table
          cells = [
            [header_cell(t("reference")), value_cell(initiative.reference)],
            [header_cell(t("created_at")), value_cell(I18n.l(initiative.created_at.to_date, format: :default))]
          ]
          composer.table(cells, **default_table_style)
        end

        def add_title_box
          add_labeled_box(
            label: t("title_label"),
            help: t("title_help"),
            content: translated_attribute(initiative.title)
          )
        end

        def add_metadata_table
          rows = [
            [header_cell(t("type_label")), value_cell(translated_attribute(initiative.type.title))],
            [header_cell(t("scope_label")), value_cell(translated_attribute(initiative.scope&.name).presence || "-")],
            [header_cell(t("signatures_label")), value_cell(initiative.supports_count)]
          ]
          composer.table(rows, **default_table_style)
        end

        def add_content_boxes
          if initiative.has_custom_fields
            add_labeled_box(label: t("question_label"), help: t("question_help"), content: translated_attribute(initiative.question))
            add_labeled_box(label: t("definition_label"), help: t("definition_help"), content: translated_attribute(initiative.definition))
            add_labeled_box(label: t("reasons_label"), help: t("reasons_help"), content: translated_attribute(initiative.reasons))
          else
            add_labeled_box(label: t("description_label"), help: t("description_help"), content: translated_attribute(initiative.description))
          end
        end

        def add_labeled_box(label:, help:, content:)
          header = {
            content: layout.formatted_text(
              [
                { text: label, font: bold_font, font_size: 11 },
                { text: " ", font_size: 10 },
                { text: help, font: italic_font, font_size: 10 }
              ]
            ),
            padding: [3, 5, 3, 5]
          }
          composer.table([[header]], cell_style: { border: { width: BORDER_WIDTH } }, style: { margin: [0, 0, 0, 0] })

          text_content = sanitize_html(content.presence || "")
          display_content = text_content.presence || "\n\n\n"

          content_width = composer.frame.available_width

          composer.text(
            display_content,
            width: content_width,
            style: {
              font:,
              font_size: 11,
              padding: CELL_PADDING,
              margin: [0, 0, 8, 0],
              border: { width: BORDER_WIDTH },
              background_color: BACKGROUND_GREY
            }
          )
        end

        def sanitize_html(html_content)
          return "" if html_content.blank?

          text = html_content.gsub(/<img[^>]*>/i, "")
          text = text.gsub(%r{</?(p|div|br|li|ul|ol|h[1-6])[^>]*>}i) { |tag| tag.start_with?("</") ? "\n" : "" }
          text = ActionController::Base.helpers.strip_tags(text)
          text = CGI.unescapeHTML(text)
          text.gsub(/[ \t]+/, " ").gsub(/\n{3,}/, "\n\n").strip
        end

        def add_authorship_section
          composer.text(t("authorship_title"), style: :section_title)
          author = initiative.author

          cells = [
            [header_cell(t("username_label")), value_cell(author&.name)],
            [header_cell(t("nickname_label")), value_cell(author&.nickname)],
            [value_cell(profile_url_for(author), col_span: 2)]
          ]
          composer.table(cells, cell_style: { border: { width: BORDER_WIDTH } }, style: { margin: [5, 0, 15, 0] })
        end

        def add_committee_section
          composer.text(t("committee_title"), style: :section_title)

          cells = initiative.committee_members.approved.includes(:user).flat_map do |member|
            user = member.user
            [
              [header_cell(t("username_label")), value_cell(user&.name)],
              [header_cell(t("nickname_label")), value_cell(user&.nickname)],
              [value_cell(profile_url_for(user), col_span: 2)]
            ]
          end

          composer.table(cells, cell_style: { border: { width: BORDER_WIDTH } }, style: { margin: [5, 0, 15, 0] }) if cells.any?
        end

        def profile_url_for(user)
          return "" unless user

          Decidim::Core::Engine.routes.url_helpers.profile_url(user.nickname, host: initiative.organization.host)
        rescue StandardError
          ""
        end

        def add_date_section
          composer.formatted_text(
            [
              { text: t("date_label"), font: bold_font, font_size: 11 },
              { text: " #{I18n.l(Time.current.to_date, format: :long)}", font:, font_size: 11 }
            ],
            style: { margin: [20, 0, 0, 0] }
          )
        end

        def add_legal_box
          page = composer.document.pages[-1]
          canvas = page.canvas(type: :page)
          text_box = layout.text(t("legal_text_pdf"), font:, font_size: 8, text_align: :center)
          text_box.fit(page.box.width - 100, 50, composer.frame)
          text_box.draw(canvas, 50, 40)
        end

        def italic_font
          @italic_font ||= font
        end
      end
    end
  end
end

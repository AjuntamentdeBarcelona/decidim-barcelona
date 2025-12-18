# frozen_string_literal: true

Rails.application.config.to_prepare do
  Decidim.content_blocks.register(:newsletter_template, :barcelona_custom) do |content_block|
    content_block.cell = "decidim/newsletter_templates/barcelona_custom"
    content_block.settings_form_cell = "decidim/newsletter_templates/barcelona_custom_settings_form"
    content_block.public_name_key = "decidim.newsletter_templates.barcelona_custom.name"

    content_block.images = [
      {
        name: :main_image,
        uploader: "Decidim::NewsletterTemplateImageUploader",
        preview: -> { ActionController::Base.helpers.asset_pack_path("media/images/placeholder.jpg") }
      }
    ]

    content_block.settings do |settings|
      settings.attribute(
        :body,
        type: :text,
        translated: true,
        preview: -> { I18n.t("decidim.newsletter_templates.basic_only_text.body_preview") }
      )
    end

    content_block.default!
  end
end

# frozen_string_literal: true

module Decidim
  module NewsletterTemplates
    class BarcelonaCustomCell < BaseCell
      def body
        interpolate(model.settings.body)
      end

      def has_main_image?
        newsletter.template.images_container.main_image.attached?
      end

      def main_image
        image_tag main_image_url
      end

      private

      def interpolate(attribute)
        parse_interpolations(translated_attribute(attribute), recipient_user, newsletter.id)
      end

      def main_image_url
        newsletter.template.images_container.attached_uploader(:main_image).url
      end
    end
  end
end

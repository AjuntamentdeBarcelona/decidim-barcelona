# frozen_string_literal: true

module Decidim
  module Overrides
    module Initiatives
      module ApplicationFormPDF
        private

        def add_initiative_metadata_box
          composer.text(I18n.t("initiative.type", scope: "decidim.initiatives.initiatives.print"), style: :text)
          composer.text(translated_attribute(initiative.type.title), style: :td)
          composer.text(I18n.t("initiative.title", scope: "decidim.initiatives.initiatives.print"), style: :text)
          composer.text(translated_attribute(initiative.title), style: :td)
          if initiative.has_custom_fields
            composer.text(I18n.t("decidim.initiatives.show.definition"), style: :text)
            composer.text(translated_attribute(initiative.definition), style: :td)
            composer.text(I18n.t("decidim.initiatives.show.reasons"), style: :text)
            composer.text(translated_attribute(initiative.reasons), style: :td)
            composer.text(I18n.t("decidim.initiatives.show.question"), style: :text)
            composer.text(translated_attribute(initiative.question), style: :td)
          else
            composer.text(I18n.t("initiative.description", scope: "decidim.initiatives.initiatives.print"), style: :text)
            composer.text(translated_attribute(initiative.description), style: :td)
          end
        end

      end
    end
  end
end

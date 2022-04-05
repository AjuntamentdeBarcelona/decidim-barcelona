# frozen_string_literal: true

gem_dir   = Gem::Specification.find_by_name("decidim-core").gem_dir
file_path = "app/helpers/decidim/decidim_form_helper"

require "#{gem_dir}/#{file_path}"

module Decidim
  module EphemeralParticipation
    module DecidimFormHelperOverride
      extend ActiveSupport::Concern

      included do
        # TEMPORARY OVERRIDE TO RENDER LINKS ON BASE ERROR MESSAGES (BUG IN DECIDIM)
        # https://github.com/decidim/decidim/blob/c967ffe21fb627239f838c1a1dc3b52fb97b0c84/decidim-core/app/helpers/decidim/decidim_form_helper.rb#L213

        def base_error_messages(record)
          return unless record.respond_to?(:errors)
          return unless record.errors[:base].any?

          alert_box(record.errors.full_messages_for(:base).join(",").html_safe, "alert", false)
        end
      end
    end
  end
end

Decidim::DecidimFormHelper.include(Decidim::EphemeralParticipation::DecidimFormHelperOverride)

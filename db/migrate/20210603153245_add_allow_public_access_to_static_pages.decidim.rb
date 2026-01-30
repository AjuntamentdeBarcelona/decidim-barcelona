# frozen_string_literal: true

# This migration comes from decidim (originally 20201128130723)
# This file has been modified by `decidim upgrade:migrations` task on 2025-09-01 14:03:13 UTC
class AddAllowPublicAccessToStaticPages < ActiveRecord::Migration[5.2]
  def change
    add_column :decidim_static_pages, :allow_public_access, :boolean, null: false, default: false

    reversible do |direction|
      direction.up do
        # rubocop:disable Rails/SkipsModelValidations
        Decidim::StaticPage.where(slug: ["terms-and-conditions", "terms-of-service"]).update_all(
          allow_public_access: true
        )
        # rubocop:enable Rails/SkipsModelValidations
      end
    end
  end
end

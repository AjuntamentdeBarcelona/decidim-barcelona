class FixEmailUniquenessIndex < ActiveRecord::Migration[5.0]
  def change
    remove_index :decidim_users, name: :index_unique_user_on_email_not_erased
    add_index :decidim_users,
              ["email", "decidim_organization_id"],
              unique: true,
              where: "(imported_erased_at IS NULL)",
              name: "index_unique_user_on_email_not_erased"
  end
end

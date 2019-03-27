class AllowErasedUsers < ActiveRecord::Migration[5.0]
  def change
    ActiveRecord::Base.transaction do
      add_column :decidim_users, :imported_erased_at, :datetime
      change_column_null :decidim_users, :name, true
      change_column_null :decidim_users, :email, true
      remove_index :decidim_users, name: "index_decidim_users_on_email"
      add_index :decidim_users,
                "email",
                unique: true,
                where: "(imported_erased_at IS NULL)",
                name: "index_unique_user_on_email_not_erased"
    end
  end
end

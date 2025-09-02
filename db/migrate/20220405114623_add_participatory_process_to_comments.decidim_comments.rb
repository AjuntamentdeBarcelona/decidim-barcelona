# frozen_string_literal: true

# This migration comes from decidim_comments (originally 20210402124534)
# This file has been modified by `decidim upgrade:migrations` task on 2025-09-01 14:03:12 UTC
class AddParticipatoryProcessToComments < ActiveRecord::Migration[5.2]
  def change
    add_column :decidim_comments_comments, :decidim_participatory_space_type, :string
    add_column :decidim_comments_comments, :decidim_participatory_space_id, :integer

    add_index :decidim_comments_comments,
              [:decidim_participatory_space_id, :decidim_participatory_space_type],
              name: "index_decidim_comments_on_decidim_participatory_space"
  end
end

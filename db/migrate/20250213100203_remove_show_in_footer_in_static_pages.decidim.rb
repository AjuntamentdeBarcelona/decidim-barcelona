# frozen_string_literal: true

# This migration comes from decidim (originally 20240326104215)
class RemoveShowInFooterInStaticPages < ActiveRecord::Migration[6.1]
  def change
    remove_column :decidim_static_pages, :show_in_footer, :boolean
  end
end

# frozen_string_literal: true

# This migration comes from decidim_participatory_processes (originally 20241108141514)
class RemoveColumnBannerImageFromParticipatoryProcesses < ActiveRecord::Migration[7.0]
  def change
    remove_column :decidim_participatory_processes, :banner_image, :string
  end
end

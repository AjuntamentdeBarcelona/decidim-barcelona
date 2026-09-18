# frozen_string_literal: true

# This migration comes from decidim_participatory_processes (originally 20251007094913)
class RemoveCtaPathAndTextFromSteps < ActiveRecord::Migration[7.2]
  def change
    remove_column :decidim_participatory_process_steps, :cta_text, :jsonb
    remove_column :decidim_participatory_process_steps, :cta_path, :string
  end
end

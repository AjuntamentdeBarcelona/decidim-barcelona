# frozen_string_literal: true

# This migration comes from decidim_assemblies (originally 20240712061153)
class ChangeShowStatisticsFromDecidimAssemblies < ActiveRecord::Migration[7.0]
  def up
    change_column_default :decidim_assemblies, :show_statistics, from: false, to: true
  end

  def down
    change_column_default :decidim_assemblies, :show_statistics, from: true, to: false
  end
end

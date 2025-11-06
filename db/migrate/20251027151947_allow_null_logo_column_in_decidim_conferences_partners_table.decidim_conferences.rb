# frozen_string_literal: true

# This migration comes from decidim_conferences (originally 20210408204953)
class AllowNullLogoColumnInDecidimConferencesPartnersTable < ActiveRecord::Migration[6.0]
  def change
    change_column_null :decidim_conferences_partners, :logo, true
  end
end

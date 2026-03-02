# frozen_string_literal: true

# This migration comes from decidim (originally 20200806092109)
# This file has been modified by `decidim upgrade:migrations` task on 2025-09-01 14:03:13 UTC
class AddMachineTranslationDisplayPriorityToOrganizations < ActiveRecord::Migration[5.2]
  class Organization < ApplicationRecord
    self.table_name = "decidim_organizations"
  end

  def change
    add_column :decidim_organizations, :machine_translation_display_priority, :string

    Organization.reset_column_information
    Organization.update_all(machine_translation_display_priority: :original) # rubocop:disable Rails/SkipsModelValidations

    change_column_default :decidim_organizations, :machine_translation_display_priority, "original"
    change_column_null :decidim_organizations, :machine_translation_display_priority, false
  end
end

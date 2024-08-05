# frozen_string_literal: true
# This migration comes from decidim_decidim_awesome (originally 20240306175331)

class RenameEditorImagesAwesomeConfig < ActiveRecord::Migration[6.1]
  class AwesomeConfig < ApplicationRecord
    self.table_name = :decidim_awesome_config
  end

  # rubocop:disable Rails/SkipsModelValidations
  def up
    AwesomeConfig.where(var: :allow_images_in_full_editor).update_all(var: :allow_images_in_editors)
    AwesomeConfig.where(var: :allow_images_in_small_editor).destroy_all
  end

  def down
    AwesomeConfig.where(var: :allow_images_in_editors).update_all(var: :allow_images_in_full_editor)
  end
  # rubocop:enable Rails/SkipsModelValidations
end

# This migration comes from decidim_consultations (originally 20180320100658)
# frozen_string_literal: true

class AddIntroductoryImageToDecidimConsultations < ActiveRecord::Migration[5.1]
  def change
    add_column :decidim_consultations, :introductory_image, :string
  end
end

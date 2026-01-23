# frozen_string_literal: true

# This migration comes from decidim (originally 20170220110740)
# This file has been modified by `decidim upgrade:migrations` task on 2025-09-01 14:03:13 UTC
class RemoveStepsShortDescription < ActiveRecord::Migration[5.0]
  class ParticipatoryProcessStep < ApplicationRecord
    self.table_name = :decidim_participatory_process_steps
  end

  def change
    ParticipatoryProcessStep.transaction do
      ParticipatoryProcessStep.find_each do |step|
        step.update!(
          description: new_description_for(step)
        )
      end

      remove_column :decidim_participatory_process_steps, :short_description
    end
  end

  def new_description_for(step)
    desc = {}
    step.description.keys.each do |locale|
      desc[locale] = step.short_description[locale] + step.description[locale]
    end
    desc
  end
end

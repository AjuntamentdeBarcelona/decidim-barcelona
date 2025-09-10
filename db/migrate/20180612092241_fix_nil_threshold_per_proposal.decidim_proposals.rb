# frozen_string_literal: true

# This migration comes from decidim_proposals (originally 20180413135249)
# This file has been modified by `decidim upgrade:migrations` task on 2025-09-01 14:03:13 UTC
class FixNilThresholdPerProposal < ActiveRecord::Migration[5.1]
  class Component < ApplicationRecord
    self.table_name = :decidim_components
  end

  def change
    proposal_components = Component.where(manifest_name: "proposals")

    proposal_components.each do |component|
      settings = component.attributes["settings"]
      settings["global"]["threshold_per_proposal"] ||= 0
      component.settings = settings
      component.save
    end
  end
end

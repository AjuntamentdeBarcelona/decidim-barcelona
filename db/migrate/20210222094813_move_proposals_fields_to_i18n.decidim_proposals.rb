# frozen_string_literal: true
# This migration comes from decidim_proposals (originally 20200708091228)

class MoveProposalsFieldsToI18n < ActiveRecord::Migration[5.2]
  # We empty this migration because it was split into different steps earlier.
  # We need to keep the file so that Dceidim doesn't copy it every time we
  # upgrade.
  def up; end

  def down; end
end

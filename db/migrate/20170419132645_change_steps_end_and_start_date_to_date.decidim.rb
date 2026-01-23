# frozen_string_literal: true

# This migration comes from decidim (originally 20170404132616)
# This file has been modified by `decidim upgrade:migrations` task on 2025-09-01 14:03:13 UTC
class ChangeStepsEndAndStartDateToDate < ActiveRecord::Migration[5.0]
  def change
    change_column :decidim_participatory_process_steps, :start_date, :date
    change_column :decidim_participatory_process_steps, :end_date, :date
  end
end

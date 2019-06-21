# frozen_string_literal: true
# This migration comes from decidim_participatory_processes (originally 20190322125517)

class AddAreaToParticipatoryProcesses < ActiveRecord::Migration[5.2]
  def change
    add_reference :decidim_participatory_processes, :decidim_area, index: true
  end
end

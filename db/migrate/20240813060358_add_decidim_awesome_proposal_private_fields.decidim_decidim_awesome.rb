# frozen_string_literal: true
# This migration comes from decidim_decidim_awesome (originally 20240531224204)

class AddDecidimAwesomeProposalPrivateFields < ActiveRecord::Migration[6.0]
  class ProposalExtraField < ApplicationRecord
    self.table_name = :decidim_awesome_proposal_extra_fields
  end

  def change
    add_column :decidim_awesome_proposal_extra_fields, :private_body, :string
    add_column :decidim_awesome_proposal_extra_fields, :decidim_proposal_type, :string
    reversible do |direction|
      direction.up do
        execute <<~SQL.squish
          UPDATE decidim_awesome_proposal_extra_fields
          SET decidim_proposal_type = 'Decidim::Proposals::Proposal'
        SQL
      end
    end

    remove_index :decidim_awesome_proposal_extra_fields, name: "decidim_awesome_extra_fields_on_proposal"
    add_index :decidim_awesome_proposal_extra_fields,
              [:decidim_proposal_id, :decidim_proposal_type],
              name: "index_decidim_awesome_proposal_extra_fields_on_decidim_proposal"

    change_column_null :decidim_awesome_proposal_extra_fields, :decidim_proposal_id, false
    change_column_null :decidim_awesome_proposal_extra_fields, :decidim_proposal_type, false
    ProposalExtraField.reset_column_information
  end
end

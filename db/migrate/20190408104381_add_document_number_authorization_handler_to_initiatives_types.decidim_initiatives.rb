# frozen_string_literal: true
# This migration comes from decidim_initiatives (originally 20190125131847)

class AddDocumentNumberAuthorizationHandlerToInitiativesTypes < ActiveRecord::Migration[5.2]
  def change
    add_column :decidim_initiatives_types, :document_number_authorization_handler, :string
  end
end

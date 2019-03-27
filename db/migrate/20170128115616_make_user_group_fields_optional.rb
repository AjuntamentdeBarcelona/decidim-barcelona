class MakeUserGroupFieldsOptional < ActiveRecord::Migration[5.0]
  def change
    change_column_null :decidim_user_groups, :document_number, true
    change_column_null :decidim_user_groups, :phone, true
  end
end

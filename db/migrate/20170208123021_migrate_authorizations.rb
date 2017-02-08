class MigrateAuthorizations < ActiveRecord::Migration[5.0]
  def change
    Decidim::Authorization.all.find_each do |authorization|
      metadata = authorization.metadata
      scope_id = metadata["scope_id"]

      next unless scope_id.present?

      authorization.update_attribute(:metadata, {
                                       postal_code: metadata["postal_code"],
                                       scope: Decidim::Scope.find(scope_id).name
                                     })
    end
  end
end

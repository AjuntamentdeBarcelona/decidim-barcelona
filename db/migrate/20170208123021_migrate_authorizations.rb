class MigrateAuthorizations < ActiveRecord::Migration[5.0]
  def change
    Decidim::Authorization.each do |authorization|
      scope_id = authorization.metadata["scope_id"]

      next unless scope_id.present?

      authorization.update_attribute(:metadata, {
                                       postal_code: metadata["postal_code"],
                                       scope: Decidim::Scope.find(scope_id)
                                     })
    end
  end
end

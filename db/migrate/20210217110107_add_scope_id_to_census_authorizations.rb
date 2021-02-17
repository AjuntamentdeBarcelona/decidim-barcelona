class AddScopeIdToCensusAuthorizations < ActiveRecord::Migration[5.2]
  def up
    scopes = Decidim::Scope.all
    scopes_by_name = scopes.map{ |scope| [scope.name["ca"], scope.id] }.to_h

    Decidim::Authorization.where(name: "census_authorization_handler").find_each do |auth|
      scope_name = cleanup_scope_name(auth.metadata["scope"])
      scope_id = scopes_by_name[scope_name]

      raise "ERROR: #{scope_name} scope not found for auth #{auth.id}" unless scope_id rescue byebug
      auth.metadata["scope"] = scope_name
      auth.metadata["scope_id"] = scope_id
      auth.save
    end
  end

  def down; end

  def cleanup_scope_name(name)
    case name
    when "Horta-Guinardó"
      "Horta - Guinardó"
    when "Sants-Montjuïc"
      "Sants - Montjuïc"
    else
      name
    end
  end
end

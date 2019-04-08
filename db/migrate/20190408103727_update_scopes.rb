class UpdateScopes < ActiveRecord::Migration[5.2]
  def change
    city_scope = Decidim::Scope.find(11)
    districts = Decidim::Scope.where(parent_id: nil).select{|s| s.name["ca"] != "Ciutat" }
    districts.each {|district|
      district.parent = city_scope
      district.save!
    }

    pam = Decidim::ParticipatoryProcess.find(1)
    pam.scope = city_scope
    pam.save!
  end
end

require "importer"

namespace :import do
  task :scopes => :environment do
    data = Importer.read_file("scopes")

    Decidim::Scope.delete_all

    progress_bar = Importer.progress_bar("Scopes", data.length)

    organization = Decidim::Organization.first

    data.each do |scope_data|
      Decidim::Scope.create!(
        id: scope_data.fetch("id"),
        name: scope_data.fetch("name"),
        organization: organization
      )

      progress_bar.increment
    end

    Importer.fix_auto_increment("decidim_scopes")
  end
end

# coding: utf-8
require "importer"

namespace :import do
  task :pages => :environment do
    progress_bar = Importer.progress_bar("Pages", 2)
    organization = Decidim::Organization.first

    organization.static_pages.delete_all

    Decidim::StaticPage.create!(
      title: {ca: "Termes i condicions d'ús", es: "Términos y condiciones de uso"},
      content: {
        ca: File.read(Rails.root.join("db/seeds/terms.ca.html")),
        es: File.read(Rails.root.join("db/seeds/terms.es.html"))
      },
      slug: "terms-and-conditions",
      organization: organization
    )

    progress_bar.increment

    Decidim::StaticPage.create!(
      title: {ca: "Més informació", es: "Más información"},
      content: {
        ca: File.read(Rails.root.join("db/seeds/more-information.ca.html")),
        es: File.read(Rails.root.join("db/seeds/more-information.es.html"))
      },
      slug: "more-information",
      organization: organization
    )

    progress_bar.increment

    Importer.fix_auto_increment("decidim_static_pages")
  end
end

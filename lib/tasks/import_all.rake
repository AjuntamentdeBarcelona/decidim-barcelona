# coding: utf-8
namespace :import do
  task :all => :environment do
    Decidim::Organization.delete_all

    Decidim::Organization.create!(
      name: "decidim.barcelona",
      host: "decidim-barcelona.herokuapp.com",
      available_locales: ["ca", "es"],
      default_locale: "ca",
      remote_homepage_image_url: "https://decidim.barcelona/assets/hero-home-0db7332ec7fbcc9af56c7dde8df3716ce8227d6044ad5f74476ad2dc70793d63.jpg",
      remote_logo_url: "https://i.imgur.com/tHG04IS.png",
      twitter_handler: "decidimbcn",
      welcome_text: {
        ca: "Decidim la Barcelona que volem",
        es: "Decidamos la Barcelona que queremos"
      },
      description: {
        ca: "Benvingut/da a la plataforma de participació de Barcelona.
Construïm una ciutat més oberta, transparent i col·laborativa.
Entra, participa i decideix",
        es: "Bienvenido/a a la plataforma de participación de Barcelona.
Contruyamos una ciudad más abierta, transparente y colaborativa.
Entra, participa y decide."
      }
    )

    puts "Importing users..."
    Rake::Task["import:users"].invoke

    puts "Importing user groups..."
    Rake::Task["import:user_groups"].invoke

    puts "Importing scopes.."
    Rake::Task["import:scopes"].invoke

    puts "Importing processes..."
    Rake::Task["import:processes"].invoke

    puts "Importing categories..."
    Rake::Task["import:categories"].invoke

    puts "Importing proposals..."
    Rake::Task["import:proposals"].invoke

    puts "Importing proposal votes..."
    Rake::Task["import:proposal_votes"].invoke

    puts "Importing results..."
    Rake::Task["import:results"].invoke

    puts "Importing debates..."
    Rake::Task["import:debates"].invoke

    puts "Importing proposals..."
    Rake::Task["import:meetings"].invoke

    puts "Importing comments..."
    Rake::Task["import:comments"].invoke

    puts "Data importing finished! Let's update attachments now - that could take a while!"

    puts "Importing attachments..."
    Rake::Task["import:attachments"].invoke

    puts "Importing meeting attachments..."
    Rake::Task["import:meeting_attachments"].invoke
  end
end

require "importer"

namespace :import do
  task :categories => :environment do
    ActiveRecord::Base.transaction do
      data = Importer.read_file("categories")

      Decidim::Category.delete_all

      progress_bar = Importer.progress_bar("Categories", data.length)

      mappings = {
        categories: {},
        subcategories: {}
      }

      data.group_by{ |c| c.fetch("process_id") }.each do |process_id, categories|
        categories.each do |category_data|
          process = Decidim::ParticipatoryProcess.find(category_data["process_id"])

          category = Decidim::Category.create!(
            name: category_data.fetch("name"),
            description: category_data.fetch("description"),
            participatory_process: process
          )

          mappings[:categories][category_data.fetch("id")] = category.id

          subcategories = category_data.fetch("categories").map do |subcategory_data|
            subcategory = Decidim::Category.create!(
              name: subcategory_data.fetch("name"),
              description: subcategory_data.fetch("description"),
              participatory_process: process,
              parent: category
            )

            mappings[:subcategories][subcategory_data.fetch("id")] = subcategory.id
            subcategory
          end

          mappings[:categories].delete(category_data.fetch("id"))

          if categories.length == 1
            subcategories.each { |sc| sc.update_attributes(parent_id: nil) }
            category.destroy
          end

          progress_bar.increment
        end
      end


      File.write(
        Rails.root.join("imports", "category_mappings.json"),
        JSON.pretty_generate(mappings)
      )

      Importer.fix_auto_increment("decidim_categories")
    end
  end
end

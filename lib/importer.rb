module Importer
  def read_file(name)
    JSON.parse(File.read(Rails.root.join("imports/#{name}.json")))
  end
  module_function :read_file

  def progress_bar(name, length)
    ProgressBar.create(
      format: "%a /%e %b\u{15E7}%i %p%% %t",
      progress_mark: ' ',
      remainder_mark: "\u{FF65}",
      title: name,
      total: length
    )
  end
  module_function :progress_bar

  def category_from(category_id, subcategory_id)
    return unless category_id.present? || subcategory_id.present?

    @category_mappings ||= JSON.parse(File.read(Rails.root.join("imports/category_mappings.json")))

    id = if subcategory_id
           @category_mappings["subcategories"][subcategory_id.to_s]
         else
           @category_mappings["categories"][category_id.to_s]
         end

    Decidim::Category.find(id)
  end
  module_function :category_from

  def fake_i18n(text)
    {
      ca: text,
      es: text
    }
  end
  module_function :fake_i18n

  def fix_auto_increment(table)
    ActiveRecord::Base.connection.execute(
      "SELECT setval('#{table}_id_seq', (select max(id) from #{table}))"
    )
  end
  module_function :fix_auto_increment
end

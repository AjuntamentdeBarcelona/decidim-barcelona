# frozen_string_literal: true

namespace :decidim do
  namespace :accountability do
    # This task performs a check on the accountability data, based in a CSV provided.
    #
    # The format of the CSV is:
    # "PAM/PAD","Eje","Linea","Actuacion","Proyecto","ID","Progreso","Peso"
    #
    # - PAM/PAD: the scope
    # - Eje: category
    # - Linea: subcategory
    # - Actuacion: parent result
    # - Project: children result
    # - ID: the external ID
    # - Progreso: the progress
    # - Peso: weight (this field only applies to projects)
    #
    # The output of the checker contains the name of each check and the items that don't
    # match the check. When the check is ok it doesn't print any message
    desc "Checks the data compared with a dump from ProjectMonitor"
    task :check, [:csv_file_path] => [:environment] do |t, args|
      Decidim::Accountability::DataChecker.new(args[:csv_file_path]).check
    end
  end
end

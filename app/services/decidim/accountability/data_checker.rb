# frozen_string_literal: true
require "csv"

module Decidim
  module Accountability
    # This class implements a very custom data check on the Accountability module
    class DataChecker
      # Public: Initializes the service.
      # csv_file_path - The path to the csv file.
      def initialize(csv_file_path)
        @data = CSV.read(csv_file_path, headers: true)
        @results = Decidim::Accountability::Result.all.select{ |r| r.feature.participatory_space_type == "Decidim::ParticipatoryProcess" && r.feature.participatory_space_id == 1 }
        @parent_results = Decidim::Accountability::Result.where(parent_id: nil).select{ |r| r.feature.participatory_space_type == "Decidim::ParticipatoryProcess" && r.feature.participatory_space_id == 1 }
        @projects = Decidim::Accountability::Result.where.not(parent_id: nil).select{ |r| r.feature.participatory_space_type == "Decidim::ParticipatoryProcess" && r.feature.participatory_space_id == 1 }
      end

      CATEGORIES_MAPPING = {
        "AUTONOMÍA PERSONAL" => "AUTONOMIA PERSONAL",
        "CICLES DE VIDA" => "CICLE DE VIDA",
        "GOVERN TRANSPARENT  I RENDICIÓ DE COMPTES" => "GOVERN TRANSPARENT I RENDICIÓ DE COMPTES",
        "ADMINISTRACIÓ  INTEL·LIGENT I INCLUSIVA" => "ADMINISTRACIÓ INTEL·LIGENT I INCLUSIVA"
      }

      SCOPES_MAPPING = {
        "0. PAM" => "11",
        "01. PAD CIUTAT VELLA 2016" => "1",
        "02. PAD EIXAMPLE" => "2",
        "03. PAD SANTS - MONTJUÏC" => "3",
        "04. PAD LES CORTS" => "4",
        "05. PAD SARRIÀ - SANT GERVASI" => "5",
        "06. PAD GRÀCIA" => "6",
        "07. PAD HORTA - GUINARDÓ" => "7",
        "08. PAD NOU BARRIS" => "8",
        "09. PAD SANT ANDREU" => "9",
        "10. PAD SANT MARTÍ" => "10"
      }

      def check
        check_results_without_external_id
        check_csv_results_and_projects_are_matched(extract_parent_results(data), extract_children_results(data))
        check_results_and_projects_not_in_csv(extract_parent_results(data), extract_children_results(data))
        check_results_scopes(extract_parent_results(data))
        check_results_subcategories(extract_parent_results(data))
        # TODO
        # check_results_projects(extract_parent_results(data), extract_children_results(data))
        check_projects_weight_and_progress(extract_children_results(data))
        check_parent_results_progress(extract_parent_results(data))
      end

      private

      attr_reader :data, :results, :parent_results, :projects

      def extract_scopes(data)
        @extract_scopes ||= data.map do |row|
          row if row["Eje"].blank? && row["Linea"].blank? && row["Actuacion"].blank? && row["Proyecto"].blank?
        end.compact
      end

      def extract_parent_results(data)
        @extract_parent_results ||= data.map do |row|
          row if row["Eje"].present? && row["Linea"].present? && row["Actuacion"].present? && row["Proyecto"].blank?
        end.compact
      end

      def extract_children_results(data)
        @extract_children_results ||= data.map do |row|
          row if row["Eje"].present? && row["Linea"].present? && row["Actuacion"].present? && row["Proyecto"].present?
        end.compact
      end

      def check_results_without_external_id
        puts "- Running check no results with nil external_id"
        results_with_nil_external_id = results.select{ |r| r.external_id.nil? }
        results_with_nil_external_id.each do |result|
          puts ["  - No external ID found: ", result.id, result.title].join(" - ")
        end
        puts
      end

      def check_csv_results_and_projects_are_matched(parents, children)
        puts "- Running check CSV results and projects are matched in the database"
        parents.each do |row|
          result = parent_results.detect{ |r| r.external_id == "pm-act-#{row["ID"]}" }
          puts "  - Parent result not found in the database: #{row.inspect}" if result.nil?
        end
        children.each do |row|
          result = projects.detect{ |r| r.external_id == row["ID"] }
          puts "  - Project not found in the database: #{row.inspect}" if result.nil?
        end
        puts
      end

      def check_results_and_projects_not_in_csv(parents, children)
        puts "- Running check database results exist in the CSV"
        parent_results.each do |result|
          next if result.external_id.nil?
          row = parents.detect{ |row| row["ID"].to_s == result.external_id.split("-").last }
          puts "  - Parent result not found in the CSV: #{result.id} #{result.title}" if row.nil?
        end
        projects.each do |result|
          next if result.external_id.nil?
          row = children.detect{ |row| row["ID"].to_s == result.external_id.to_s }
          puts "  - Project not found in the CSV: #{result.id} #{result.title}" if row.nil?
        end
        puts
      end

      def check_results_scopes(parents)
        puts "- Running check results are in the scope"
        parents.each do |row|
          if result = parent_results.detect{ |r| r.external_id == "pm-act-#{row["ID"]}" }
            puts " - Parent result scope is invalid #{result.id} #{result.title['ca']}" if SCOPES_MAPPING[row["PAM/PAD"]] != result.scope.id.to_s
          end
        end
        puts
      end

      def check_results_subcategories(parents)
        def matches_category?(category, csv_category)
          csv_category = csv_category.split(" ")[1..-1].join(" ").upcase.strip
          category = category.name['ca'].upcase.strip
          (CATEGORIES_MAPPING[category] || category) == csv_category
        end

        puts "- Running check results are in the subcategory"
        parents.each do |row|
          if result = parent_results.detect{ |r| r.external_id == "pm-act-#{row["ID"]}" }
            puts " - Parent result category is invalid #{result.id} #{result.title}" unless matches_category?(result.category, row["Linea"])
          end
        end
        puts
      end

      def check_projects_weight_and_progress(children)
        puts "- Running check on weight and progress in projects"
        projects.each do |result|
          next if result.external_id.nil?
          row = children.detect{ |row| row["ID"].to_s == result.external_id.to_s }
          next if row.nil?
          row_weight = row["Peso"].blank? ?  1.0 : (row["Peso"].to_f / 100.0)
          puts "  - Project weight invalid: #{result.id} #{result.title['ca']}. Is #{result.weight.round(4)} and should be #{row_weight.round(4)}" if row_weight.round(4) != result.weight.round(4)
          row_progress = row["Progreso"].to_f
          puts "  - Project progress invalid: #{result.id} #{result.title['ca']}. Is #{result.progress.round(4)} and should be #{row_progress.round(4)}" if row_progress.round(4) != result.progress.round(4)
        end
        puts
      end

      def check_parent_results_progress(parents)
        puts "- Running check on progress in parent results"
        parent_results.each do |result|
          next if result.external_id.nil?
          row = parents.detect{ |row| row["ID"].to_s == result.external_id.split("-").last }
          next if row.nil?
          row_progress = row["Progreso"].to_f
          puts "  - Parent result progress nil: #{result.id} #{result.title['ca']}" if result.progress.nil? && row_progress != 0
          puts "  - Parent result progress invalid: #{result.id} #{result.title['ca']}. Is #{result.progress.round(4)} and should be #{row_progress.round(4)}" if result.progress && (row_progress.to_f.round(4) != result.progress.to_f.round(4))
        end
        puts
      end
    end
  end
end

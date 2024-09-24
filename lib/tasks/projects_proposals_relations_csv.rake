# frozen_string_literal: true

require "csv"

namespace :import_projects_proposals_relations_csv do
  # Given a path to a csv with the headers :project_id and :proposal_id
  # this tasks links the proposal to the project
  desc "Links proposals to projects from a csv"
  task :link_resources, [:path] => :environment do |_task, args|
    args.with_defaults(
      path: "tmp/default.csv",
      link_name: "included_proposals"
    )
    path = Rails.root.join(args.path)

    begin
      raise PathArgumentError unless File.exist?(path)

      log_info "[import_projects_proposals_relations_csv:link_resources] Importing csv file from #{path}..."

      CSV.foreach(path, headers: true) do |row|
        project = Decidim::Budgets::Project.find(row["project_id"])
        proposal = Decidim::Proposals::Proposal.find(row["proposal_id"])

        raise ProjectError unless project
        raise ProposalError unless proposal

        create_link(project:, proposal:, link_name: args.link_name)
      end

      log_info "[import_projects_proposals_relations_csv:link_resources] Done linking resources"
    rescue PathArgumentError
      log_error("[import_projects_proposals_relations_csv:link_resources] ⨯ Csv file not found in path #{path}!")
      log_error "ie: bundle exec rake 'import_projects_proposals_relations_csv:link_resources[tmp/link_resources.csv]"
    rescue ProjectError
      log_error("[import_projects_proposals_relations_csv:link_resources] ⨯ Project record not found with id #{row["project_id"]}!")
    rescue ProposalError
      log_error("[import_projects_proposals_relations_csv:link_resources] ⨯ Proposal record not found with id #{row["proposal_id"]}!")
    end
  end

  def create_link(project:, proposal:, link_name:)
    linked_proposals = project.linked_resources(:proposals, link_name) || []
    linked_proposal_ids = linked_proposals.pluck(:id)

    if linked_proposal_ids.include?(proposal.id)
      log_info "🏳  Previously linked: proposal_id #{proposal.id} to project_id #{project.id} - as '#{link_name}'"
    else
      proposals = linked_proposals + [proposal]
      project.link_resources(proposals, link_name)
      log_info "✔ Just linked: proposal_id #{proposal.id} to project_id #{project.id} - as '#{link_name}'. Currently linked proposals: #{proposals.pluck(:id)}"
    end
  end

  def log_info(msg)
    puts msg
    Rails.logger.info(msg)
  end

  def log_error(msg)
    puts msg
    Rails.logger.error(msg)
  end
end

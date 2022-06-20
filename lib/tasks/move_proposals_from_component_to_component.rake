# frozen_string_literal: true

namespace :move_proposals_from_component_to_component do
  # Given two component ids
  # moves the proposal records from one component to another
  desc "Moves proposals from a component to another"
  task :move, [:from_id, :to_id] => :environment do |_task, args|
    args.with_defaults(
      from_id: 4257,
      to_id: 5190
    )

    begin
      raise FromToArgumentError unless args.from_id || args.to_id

      log_info "[move_proposals_from_component_to_component:move] Starting to move proposals from #{args.from_id} to #{args.to_id}..."

      from_proposal_component = Decidim::Component.find_by(id: args.from_id)
      to_proposal_component = Decidim::Component.find_by(id: args.to_id)

      raise FromProposalComponentError unless from_proposal_component
      raise ToProposalComponentError unless to_proposal_component

      proposals = Decidim::Proposals::Proposal.where(decidim_component_id: from_proposal_component.id)
      log_info "[move_proposals_from_component_to_component:move] #{proposals.size} proposal records found."

      # rubocop:disable Rails/SkipsModelValidations
      proposals.update_all(decidim_component_id: to_proposal_component.id)
      # rubocop:enable Rails/SkipsModelValidations

      log_info "[move_proposals_from_component_to_component:move] Done moving resources"
    rescue FromToArgumentError
      log_error("[move_proposals_from_component_to_component:move] ⨯ missing arguments from: #{args.from_id} or to:#{args.to_id}!")
      log_error "ie: bundle exec rake 'move_proposals_from_component_to_component:move[1,2]'"
    rescue FromProposalComponentError
      log_error("[move_proposals_from_component_to_component:move] ⨯ From Proposal Component record not found with id #{args.from_id}!")
    rescue ToProposalComponentError
      log_error("[move_proposals_from_component_to_component:move] ⨯ To Proposal Component record not found with id #{args.to_id}!")
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

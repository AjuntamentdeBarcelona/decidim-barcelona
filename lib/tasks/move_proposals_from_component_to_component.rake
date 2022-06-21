# frozen_string_literal: true

namespace :move_proposals_from_component_to_component do
  # Given two component ids
  # moves the proposal records from one component to another
  desc "Moves proposals from a component to another"
  task :move, [:source_id, :target_id] => :environment do |_task, args|
    args.with_defaults(
      source_id: 4257,
      target_id: 5190
    )

    begin
      raise SourceTargetArgumentError unless args.source_id || args.target_id

      log_info "[move_proposals_from_component_to_component:move] Starting to move proposals from source_id: #{args.source_id} to target_id: #{args.target_id}..."

      source_proposal_component = Decidim::Component.find_by(id: args.source_id)
      target_proposal_component = Decidim::Component.find_by(id: args.target_id)

      raise SourceProposalComponentError if source_proposal_component.blank?
      raise TargetProposalComponentError if target_proposal_component.blank?

      proposals = Decidim::Proposals::Proposal.where(decidim_component_id: source_proposal_component.id)
      log_info "[move_proposals_from_component_to_component:move] #{proposals.size} proposal records found."

      proposals.each do |proposal|
        proposal.decidim_component_id = target_proposal_component.id
        proposal.save!
        log_info "[move_proposals_from_component_to_component:move] ✔️ Updated proposal record: #{proposal.id}..."
      rescue ActiveRecord::RecordInvalid => e
        log_error("[move_proposals_from_component_to_component:move] ⨯ Error updating the proposal record #{proposal.id}")
        log_error e
      end

      log_info "[move_proposals_from_component_to_component:move] Done moving resources"
    rescue SourceTargetArgumentError
      log_error("[move_proposals_from_component_to_component:move] ⨯ missing arguments source: #{args.source_id} or target:#{args.target_id}!")
      log_error "ie: bundle exec rake 'move_proposals_from_component_to_component:move[1,2]'"
    rescue SourceProposalComponentError
      log_error("[move_proposals_from_component_to_component:move] ⨯ Source Proposal Component record not found with id #{args.source_id}!")
    rescue TargetProposalComponentError
      log_error("[move_proposals_from_component_to_component:move] ⨯ Target Proposal Component record not found with id #{args.target_id}!")
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

class SourceTargetArgumentError < StandardError; end
class SourceProposalComponentError < StandardError; end
class TargetProposalComponentError < StandardError; end

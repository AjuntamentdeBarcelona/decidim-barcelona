# frozen_string_literal: true

module Decidim
  module Proposals
    module ProposalsControllerOverride
      extend ActiveSupport::Concern

      included do
        def index
          if component_settings.participatory_texts_enabled?
            @proposals = Decidim::Proposals::Proposal
                         .where(component: current_component)
                         .published
                         .not_hidden
                         .only_amendables
                         .includes(:category, :scope, :attachments, :coauthorships)
                         .order(position: :asc)
            render "decidim/proposals/proposals/participatory_texts/participatory_text"
          else
            @proposals = search
                         .result
                         .published
                         .not_hidden

            @all_geocoded_proposals = @proposals.geocoded

            @proposals = reorder(@proposals)
            @proposals = paginate(@proposals)
            @proposals = @proposals.includes(:component, :coauthorships, :attachments)

            @voted_proposals = if current_user
                                 ProposalVote.where(
                                   author: current_user,
                                   proposal: @proposals.pluck(:id)
                                 ).pluck(:decidim_proposal_id)
                               else
                                 []
                               end
          end
        end
      end
    end
  end
end

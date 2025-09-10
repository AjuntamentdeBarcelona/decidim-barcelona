# frozen_string_literal: true

# This migration comes from decidim (originally 20180323102631)
# This file has been modified by `decidim upgrade:migrations` task on 2025-09-01 14:03:12 UTC
class ChangeEventNameAndClassToRenameToPublishProposalEvent < ActiveRecord::Migration[5.1]
  def up
    # rubocop:disable Rails/SkipsModelValidations
    Decidim::Notification.where(event_name: "decidim.events.proposals.proposal_created")
                         .update_all(event_name: "decidim.events.proposals.proposal_published", event_class: "Decidim::Proposals::PublishProposalEvent")
    # rubocop:enable Rails/SkipsModelValidations
  end

  def down
    # rubocop:disable Rails/SkipsModelValidations
    Decidim::Notification.where(event_name: "decidim.events.proposals.proposal_published")
                         .update_all(event_name: "decidim.events.proposals.proposal_created", event_class: "Decidim::Proposals::CreateProposalEvent")
    # rubocop:enable Rails/SkipsModelValidations
  end
end

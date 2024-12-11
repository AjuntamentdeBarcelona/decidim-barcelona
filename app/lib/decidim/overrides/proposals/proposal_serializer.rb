# frozen_string_literal: true

module Decidim
  module Overrides
    module Proposals
      module ProposalSerializer
        private

        def author_url(author)
          if author.respond_to?(:nickname)
            profile_url(author) # is a Decidim::User or Decidim::UserGroup
          elsif author.respond_to?(:title)
            meeting_url(author) # is a Decidim::Meetings::Meeting
          else
            root_url # is a Decidim::Organization
          end
        end

        def profile_url(author)
          return "" if author.respond_to?(:deleted?) && author.deleted?

          Decidim::Core::Engine.routes.url_helpers.profile_url(author.nickname, host:)
        end
      end
    end
  end
end

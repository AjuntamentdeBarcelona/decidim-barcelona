# frozen_string_literal: true

module Decidim
  module Overrides
    module SearchResourceFieldsMapper
      # Override this method to avoid an error trying to remove a comment with a nil commentable
      # as it tries to get the organization of a nil organization
      def retrieve_organization(resource)
        if @declared_fields[:organization_id].present?
          organization_id = read_field(resource, @declared_fields, :organization_id)
          Decidim::Organization.find_by(id: organization_id)
        else
          participatory_space(resource)&.organization || Decidim::Organization.first
        end
      end
    end
  end
end

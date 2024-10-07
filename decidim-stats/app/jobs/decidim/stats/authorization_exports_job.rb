# frozen_string_literal: true

module Decidim
  module Stats
    class AuthorizationExportsJob < ApplicationJob
      queue_as :default

      def perform(user, organization, filters)
        ExportMailer.export(
          user,
          export_file_name,
          export_data(organization, filters)
        ).deliver_now
      end

      def export_data(organization, filters)
        Decidim::Exporters::CSV.new(
          collection(organization, filters),
          serializer
        ).export
      end

      def export_file_name
        "authorizations_export"
      end

      def collection(organization, filters)
        Decidim::Authorization.joins(:user)
                              .where(
                                granted_at: filters[:start_date]..filters[:end_date],
                                name: filters[:name]
                              )
        Decidim::Authorization.joins(:user)
                              .where(decidim_users: { decidim_organization_id: organization.id })
                              .where(
                                granted_at: filters[:start_date]..filters[:end_date],
                                name: filters[:name]
                              )
      end

      def serializer
        Decidim::Stats::AuthorizationSerializer
      end
    end
  end
end

# frozen_string_literal: true

module Decidim
  module Stats
    class StatsMailer < Decidim::ApplicationMailer
      def stats(emails, csv)
        @organization = Decidim::Organization.first
        attachments["stats.csv"] = File.read(csv.path)

        mail(
          to: emails,
          subject: "[Decidim Barcelona] Stats #{Time.zone.today.to_s}"
        )
      end
    end
  end
end

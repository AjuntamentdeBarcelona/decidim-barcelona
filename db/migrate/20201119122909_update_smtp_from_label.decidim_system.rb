# frozen_string_literal: true
# This migration comes from decidim_system (originally 20201013132945)

class UpdateSmtpFromLabel < ActiveRecord::Migration[5.2]
  def change
    Decidim::Organization.all.each do |org|
      if org.smtp_settings&.dig(:from_email).blank? && org.smtp_settings&.dig(:from).present?
        org.smtp_settings= {from_email: org.smtp_settings[:from]}
        org.save!
      end
    end
  end
end

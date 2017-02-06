require "importer"

namespace :import do
  task :users => :environment do
    raise "Secret key base needed" unless ENV["SECRET_KEY_BASE"].present?
    secret_key_base = ENV["SECRET_KEY_BASE"]

    ActiveRecord::Base.transaction do
      Decidim::Identity.delete_all
      Decidim::Authorization.delete_all
      Decidim::User.delete_all

      organization = Decidim::Organization.first
      data = Importer.read_file("users")

      progress_bar = Importer.progress_bar("Users", data.length)

      data.each do |user_data|
        mirrored_attributes = [:id, :email, :encrypted_password, :reset_password_token, :reset_password_sent_at,
                               :remember_created_at, :sign_in_count, :current_sign_in_at, :last_sign_in_at,
                               :created_at, :updated_at, :confirmation_token, :confirmed_at, :confirmation_sent_at,
                               :unconfirmed_email, :locale, :name, :extra]

        user_attributes = mirrored_attributes.inject({}) do |attributes, attribute|
          attributes.update(attribute => user_data.fetch(attribute.to_s))
        end

        user_attributes[:newsletter_notifications] = user_data.fetch("extra").fetch("newsletter")

        user = Decidim::User.new(user_attributes)
        user.organization = organization
        user.imported_erased_at = user_data.fetch("extra").fetch("erased_at")
        user.roles = ["admin"] if user_data.dig("extra", "roles").include?("administrator")
        user.skip_confirmation!
        user.save!(validate: false)

        user_data.fetch("identities").each do |identity|
          user.identities.create!(
            provider: identity.fetch("provider"),
            uid: identity.fetch("uid"),
            created_at: identity.fetch("created_at"),
            updated_at: identity.fetch("updated_at")
          )
        end

        user_data.fetch("authorizations").each do |authorization|
          user.authorizations.create!(
            unique_id: Digest::MD5.hexdigest(
              "#{authorization.fetch("document_number")}-#{secret_key_base}"
            ),
            name: "census_authorization_handler",
            created_at: user.created_at,
            updated_at: user.created_at
          )
        end

        progress_bar.increment
      end

      Importer.fix_auto_increment("decidim_users")
    end
  end
end

# frozen_string_literal: true

# Decidim 0.32 upgraded the encryption mechanism from SHA1 to SHA256 (see "5.1. Encryption
# mechanism changes" in the release notes). Existing values still decrypt, but they are only
# rewritten as SHA256 on the next save of each record.
#
# Decidim ships tasks for its own encrypted data and hooks them onto decidim:upgrade:encryption:
#
#   Decidim::Authorization    metadata, verification_metadata  (decidim-core)
#   Decidim::InitiativesVote  encrypted_metadata               (decidim-initiatives)
#
# Nothing covers the third-party modules, so this task handles the two that encrypt data:
#
#   Decidim::DecidimAwesome::ProposalExtraField  private_body
#   Decidim::Kids::MinorData                     name, email, birthday
#
# decidim-term_customizer and decidim-internal_evaluation encrypt nothing. Re-check
# decidim-extra_censuses if it is ever re-enabled in the Gemfile.
#
# A plain save is enough: both models include Decidim::RecordEncryptor, whose
# `before_save :ensure_encrypted_attributes` re-assigns every encrypted attribute, so the
# manual AttributeEncryptor.decrypt/encrypt dance from the release notes is not needed here.
namespace :decidim_barcelona do
  namespace :upgrade do
    desc "Re-encrypt third-party module data with SHA256"
    task encryption: :environment do
      logger = Logger.new($stdout)

      targets = [
        # with_deleted is required: ProposalExtraField is acts_as_paranoid (via
        # Decidim::SoftDeletable), so the default scope would silently skip soft-deleted
        # rows and leave their private_body on SHA1 forever.
        { constant: "Decidim::DecidimAwesome::ProposalExtraField", scope: -> { Decidim::DecidimAwesome::ProposalExtraField.with_deleted } },
        { constant: "Decidim::Kids::MinorData", scope: -> { Decidim::Kids::MinorData.all } }
      ]

      targets.each do |target|
        name = target[:constant]

        unless Object.const_defined?(name)
          logger.info("[SKIP] #{name} is not defined, is the module still installed?")
          next
        end

        scope = target[:scope].call
        total = scope.count
        failed = []

        # Both models validate on save (no_more_than_one_extra_field, user_is_minor) and
        # save returns false instead of raising, so failures are collected and reported
        # rather than passing silently as success.
        scope.find_each do |record|
          failed << [record.id, record.errors.full_messages.join(", ")] unless record.save
        rescue StandardError => e
          failed << [record.id, "#{e.class}: #{e.message}"]
        end

        logger.info("[INFO] #{name}: re-encrypted #{total - failed.size}/#{total} records")
        failed.each { |id, reason| logger.error("[ERROR] #{name} ##{id} not re-encrypted: #{reason}") }
      end
    end
  end
end

Rake::Task["decidim:upgrade:encryption"].enhance do
  Rake::Task["decidim_barcelona:upgrade:encryption"].invoke
end

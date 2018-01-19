# frozen_string_literal: true

namespace :anonymize do
  desc "Checks for the environment"
  task :check do
    raise "Won't run unless the env var DISABLE_PRODUCTION_CHECK=1 is set" unless ENV["DISABLE_PRODUCTION_CHECK"]
  end

  desc "Anonymizes a production dump."
  task all: %i(users user_groups admins proposals)

  def with_progress(collection, name:)
    total = collection.count
    progressbar = create_progress_bar(total: total)

    puts "Anonymizing #{total} #{name}...\n"
    skip_logs do
      collection.find_each do |item|
        yield(item)
        progressbar.increment
      end
    end
  end

  def create_progress_bar(total:)
    ProgressBar.create(
      progress_mark:  " ",
      remainder_mark: "\u{FF65}",
      total: total,
      format: "%a %e %b\u{15E7}%i %p%% %t"
    )
  end

  def skip_logs
    previous_log_level = ActiveRecord::Base.logger.level
    ActiveRecord::Base.logger.level = 2
    yield
    ActiveRecord::Base.logger.level = previous_log_level
  end

  task proposals: [:check, :environment] do
    Decidim::Proposals::ProposalVote.delete_all

    with_progress(Decidim::Proposals::Proposal.all, name: "proposals") do |proposal|
      proposal.votes.delete_all
      Decidim::Proposals::Proposal.reset_counters(proposal.id, :proposal_votes_count)
    end
  end

  task users: [:check, :environment] do
    with_progress Decidim::User.where.not(admin: true), name: "users" do |user|
      user.update_columns(
        email: "email#{user.id}@example.org",
        name: "Anonymized User #{user.id}",
        encrypted_password: "encryptedpassword#{user.id}",
        reset_password_token: nil,
        current_sign_in_at: nil,
        last_sign_in_at: nil,
        current_sign_in_ip: nil,
        last_sign_in_ip: nil,
        invitation_token: nil,
        confirmation_token: nil,
        unconfirmed_email: nil,
        avatar: nil,
        extra: {}
      )

      user.identities.find_each do |identity|
        identity.update_columns(uid: "anonymized-identity-#{identity.id}")
      end

      Decidim::Authorization.where(user: user).find_each do |authorization|
        authorization.update_columns(unique_id: authorization.id)
      end
    end
  end

  task user_groups: [:check, :environment] do
    with_progress Decidim::UserGroup.all, name: "user groups" do |user_group|
      user_group.update_columns(
        name: "User Group #{user_group.id}",
        document_number: "document-#{user_group.id}",
        phone: "123456",
        avatar: nil
      )
    end
  end

  task admins: [:check, :environment] do
    with_progress Decidim::System::Admin.all, name: "admins" do |admin|
      admin.update_columns(
        email: "email#{admin.id}@anonymized.org",
        encrypted_password: "encryptedpassword#{admin.id}",
        reset_password_token: nil,
        unlock_token: nil
      )
    end
  end
end

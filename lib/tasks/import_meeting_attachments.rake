require "importer"

namespace :import do
  task :meeting_attachments => :environment do
    data = Importer.read_file("meeting_attachments")

    Decidim::Attachment.where(attached_to_type: "Decidim::Meetings::Meeting").delete_all

    progress_bar = Importer.progress_bar("Meeting attachments", data.length)

    data.each do |attachment_data|
      meeting = Decidim::Meetings::Meeting.where(id: attachment_data.fetch("meeting_id")).first

      if meeting && attachment_data["remote_file_url"]
        attachment = Decidim::Attachment.new(
          title: meeting.title,
          description: meeting.title,
          attached_to: meeting,
          remote_file_url: attachment_data.fetch("remote_file_url"),
        )

        begin
          attachment.save!(validate: false)
        rescue ActiveRecord::StatementInvalid, ActiveRecord::RecordInvalid
          nil
        end
      end

      progress_bar.increment
    end

    Importer.fix_auto_increment("decidim_attachments")
  end
end

require "importer"

namespace :import do
  task :attachments => :environment do
    data = Importer.read_file("attachments")

    Decidim::Attachment.delete_all

    progress_bar = Importer.progress_bar("Attachments", data.length)

    data.each do |attachment_data|
      process = Decidim::ParticipatoryProcess.find(attachment_data.fetch("process_id"))

      next unless attachment_data["remote_file_url"]

      attachment = Decidim::Attachment.new(
        attached_to: process,
        remote_file_url: attachment_data.fetch("remote_file_url"),
        description: attachment_data.fetch("description"),
        title: attachment_data.fetch("title")
      )

      begin
        attachment.save!(validate: false)
      rescue ActiveRecord::StatementInvalid, ActiveRecord::RecordInvalid
        nil
      end

      progress_bar.increment
    end

    Importer.fix_auto_increment("decidim_attachments")
  end
end

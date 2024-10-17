# frozen_string_literal: true

namespace :decidim do
  namespace :upgrade do
    namespace :content_blocks do
      desc "Use the banner image of the scoped resource on the hero content block"
      task migrate_hero_image_from_banner_image: :environment do
        logger = Logger.new($stdout)
        content_blocks = Decidim::ContentBlock.where(manifest_name: "hero", scope_name: %w(participatory_process_homepage assembly_homepage))
        logger.info("[INFO] Processing #{content_blocks.count} content blocks...")
        content_blocks.each do |content_block|
          content_block_attachment = content_block.attachments.find_by(name: "background_image")
          resource_class = case content_block.scope_name
                           when "participatory_process_homepage"
                             Decidim::ParticipatoryProcess
                           when "assembly_homepage"
                             Decidim::Assembly
                           else
                             raise NotImplementedError
                           end
          resource = resource_class.find(content_block.scoped_resource_id)

          if content_block_attachment.attached?
            logger.info("[SKIP] Content block #{content_block.id} from scoped resource #{resource_class} #{resource.id} already has a background image attachment")
            next
          end

          unless resource.banner_image.attached?
            logger.info("[SKIP] Content block #{content_block.id} scoped resource #{resource_class} #{resource.id} does not have a banner image")
            next
          end

          logger.info("[INFO] Attaching image to content block #{content_block.id} from the banner image of the scoped resource #{resource_class} #{resource.id}")
          content_block_attachment.file.attach(resource.banner_image.blob)
        rescue StandardError => e
          logger.error("[ERROR] Could not migrate content block #{content_block.id}: #{e.message}")
        end
      end
    end
  end
end

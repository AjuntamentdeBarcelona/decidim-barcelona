# frozen_string_literal: true

# When rendering proposal cards created with an image and an attachment together depending on
# PostgreSql version the image is rendered or not.
# This is because attachments have a default scope that orders by weight and all attachments have the same weight.
# Then PostgreSql orders differently between < 12 versions and higher.
# This decorator avoids this inconsistent behaviour.

Decidim::Proposals::ProposalMCell.class_eval do
  def has_image?
    model.component.settings.allow_card_image && model.attachments.find_by("content_type like '%image%'").present?
  end

  def resource_image_path
    @resource_image_path ||= has_image? ? model.attachments.find_by("content_type like '%image%'").url : nil
  end
end

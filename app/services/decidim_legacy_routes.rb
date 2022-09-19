# frozen_string_literal: true

class DecidimLegacyRoutes
  attr_reader :component_translations

  def initialize(component_translations)
    @component_translations = component_translations
  end

  # rubocop:disable Rails/FindBy
  def call(params, _request)
    process = Decidim::ParticipatoryProcess.find_by(slug: params[:process_slug]) || Decidim::ParticipatoryProcess.find(params[:process_slug])

    component_translation = component_translations[params[:component_name].to_sym]
    component_manifest_name = component_translation[0]

    component = Decidim::Component.published.find_by(
      manifest_name: component_manifest_name,
      participatory_space: process
    )

    if params[:resource_id]
      resource_class = component_translation[1]
      resource = resource_class.where("extra->>'slug' = ?", params[:resource_id]).first || resource_class.find(params[:resource_id])

      "/processes/#{process.id}/f/#{component.id}/#{component_manifest_name}/#{resource.id}"
    else
      "/processes/#{process.id}/f/#{component.id}"
    end
  end
  # rubocop:enable Rails/FindBy
end

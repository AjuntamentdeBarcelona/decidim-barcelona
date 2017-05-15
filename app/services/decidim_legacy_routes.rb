class DecidimLegacyRoutes
  def call(params, request)

    feature_translations = {
      action_plans: [:results, Decidim::Results::Result],
      meetings: [:meetings, Decidim::Meetings::Meeting],
      proposals: [:proposals, Decidim::Proposals::Proposal],
      debates: [:debates, Decidim::Debates::Debate]
    }

     process = Decidim::ParticipatoryProcess.find_by_slug(params[:process_slug]) || Decidim::ParticipatoryProcess.find(params[:process_slug])

    feature_translation = feature_translations[params[:feature_name].to_sym]
    feature_manifest_name = feature_translation[0]

    feature = Decidim::Feature.published.find_by(
      manifest_name: feature_manifest_name,
      participatory_process: process
    )

    if params[:resource_id]
      resource_class = feature_translation[1]
      resource = resource_class.where("extra->>'slug' = ?", params[:resource_id]).first || resource_class.find(params[:resource_id])

      "/processes/#{process.id}/f/#{feature.id}/#{feature_manifest_name}/#{resource.id}"
    else
      "/processes/#{process.id}/f/#{feature.id}"
    end
  end
end

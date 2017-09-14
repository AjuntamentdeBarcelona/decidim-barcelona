# frozen_string_literal: true
require "sidekiq/web"

Rails.application.routes.draw do
  get "processes/:process_slug", to: redirect { |params, _request|
    process = Decidim::ParticipatoryProcess.where(slug: params[:process_slug]).first
    process ? "/processes/#{process.id}" : "/404"
  }, constraints: { process_slug: /[^0-9]+/ }

  feature_translations = {
    action_plans: [:results, Decidim::Results::Result],
    meetings: [:meetings, Decidim::Meetings::Meeting],
    proposals: [:proposals, Decidim::Proposals::Proposal],
    debates: [:debates, Decidim::Debates::Debate]
  }

  constraints host: /(www\.)?decidim\.barcelona/ do
    get "/:process_slug/:step_id/:feature_name/(:resource_id)", to: redirect(DecidimLegacyRoutes.new(feature_translations)),
    constraints: { process_id: /[^0-9]+/, step_id: /[0-9]+/, feature_name: Regexp.new(feature_translations.keys.join("|")) }

    get "/:process_slug/:feature_name/(:resource_id)", to: redirect(DecidimLegacyRoutes.new(feature_translations)),
      constraints: { process_id: /[^0-9]+/, feature_name: Regexp.new(feature_translations.keys.join("|")) }

    get "/:feature_name/:resource_id", to: redirect { |params, _request|
      feature_translation = feature_translations[params[:feature_name].to_sym]
      resource_class = feature_translation[1]
      resource = resource_class.where("extra->>'slug' = ?", params[:resource_id]).first || resource_class.find(params[:resource_id])
      feature = resource.feature
      process = feature.participatory_process
      feature_manifest_name = feature.manifest_name
      "/processes/#{process.id}/f/#{feature.id}/#{feature_manifest_name}/#{resource.id}"
    }, constraints: { feature_name: Regexp.new(feature_translations.keys.join("|")) }
  end

  authenticate :user, lambda { |u| u.admin? } do
    mount Sidekiq::Web => '/sidekiq'
  end

  get "/accountability", to: "static#accountability", as: :accountability_static
  get "/accountability/sections", to: "static#accountability_sections", as: :accountability_sections

  mount Decidim::Core::Engine => "/"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

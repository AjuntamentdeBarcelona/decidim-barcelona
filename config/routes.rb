# frozen_string_literal: true

require "sidekiq/web"

Rails.application.routes.draw do
  component_translations = {
    action_plans: [:results, Decidim::Accountability::Result],
    meetings: [:meetings, Decidim::Meetings::Meeting],
    proposals: [:proposals, Decidim::Proposals::Proposal],
    debates: [:debates, Decidim::Debates::Debate]
  }

  # rubocop:disable Layout/LineLength
  constraints host: /(www\.)?decidim\.barcelona/ do
    get "/:process_slug/:step_id/:component_name/(:resource_id)", to: redirect(DecidimLegacyRoutes.new(component_translations)),
                                                                  constraints: {
                                                                    process_id: /[^0-9]+/,
                                                                    step_id: /[0-9]+/,
                                                                    component_name: Regexp.new(component_translations.keys.join("|"))
                                                                  }

    get "/:process_slug/:component_name/(:resource_id)", to: redirect(DecidimLegacyRoutes.new(component_translations)),
                                                         constraints: { process_slug: %r{(?!meetings)[^/]*}, process_id: /[^0-9]+/, component_name: Regexp.new(component_translations.keys.join("|")) }

    get "/:component_name/:resource_id", to: redirect { |params, _request|
      component_translation = component_translations[params[:component_name].to_sym]
      resource_class = component_translation[1]
      resource = if resource_class.column_names.include?("extra")
                   resource_class.where("extra->>'slug' = ?", params[:resource_id]).first || resource_class.find(params[:resource_id])
                 else
                   resource_class.find(params[:resource_id])
                 end
      component = resource.component
      process = component.participatory_space
      component_manifest_name = component.manifest_name == "accountability" ? "results" : component.manifest_name
      "/processes/#{process.slug}/f/#{component.id}/#{component_manifest_name}/#{resource.id}"
    }, constraints: { component_name: Regexp.new(component_translations.keys.join("|")), resource_id: %r{(?!meetings)[^/]*} }
  end
  # rubocop:enable Layout/LineLength

  get "/accountability", to: "static#accountability", as: :accountability_static
  get "/accountability/sections/:section", to: "static#accountability_sections", as: :accountability_sections

  get "/pages/faq", to: redirect("/pages/decidim")

  scope "/processes/:participatory_process_slug/f/:component_id" do
    get :export_results, to: "export_results#csv"

    get :import_results, to: "decidim/accountability/admin/import_results#new"
    post :import_results, to: "decidim/accountability/admin/import_results#create"
  end

  # Temporal fix for disabling global search until we fix the performance with a big database
  match "/search", to: ->(_) { [404, {}, ["Not Found"]] }, via: :all

  mount Decidim::Core::Engine => "/"
  mount Decidim::Stats::Engine, at: "/stats", as: "decidim_stats"
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
  authenticate :user, ->(u) { u.admin? } do
    mount Sidekiq::Web => "/sidekiq"
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

# frozen_string_literal: true

require "sidekiq/web"

Rails.application.routes.draw do
  component_translations = {
    action_plans: [:results, Decidim::Accountability::Result],
    meetings: [:meetings, Decidim::Meetings::Meeting],
    proposals: [:proposals, Decidim::Proposals::Proposal],
    debates: [:debates, Decidim::Debates::Debate]
  }

  # rubocop:disable Rails/FindBy
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
      component_manifest_name = component.manifest_name
      "/processes/#{process.id}/f/#{component.id}/#{component_manifest_name}/#{resource.id}"
    }, constraints: { component_name: Regexp.new(component_translations.keys.join("|")), resource_id: %r{(?!meetings)[^/]*} }
  end
  # rubocop:enable Rails/FindBy
  # rubocop:enable Layout/LineLength

  authenticate :user, ->(u) { u.admin? } do
    mount Sidekiq::Web => "/sidekiq"
  end

  get "/accountability", to: "static#accountability", as: :accountability_static
  get "/accountability/sections", to: "static#accountability_sections", as: :accountability_sections

  scope "/processes/:participatory_process_slug/f/:component_id" do
    get :export_results, to: "export_results#csv"

    get :import_results, to: "decidim/accountability/admin/import_results#new"
    post :import_results, to: "decidim/accountability/admin/import_results#create"
  end

  get "/pages/faq", to: redirect("/pages/more-information")

  mount Decidim::Core::Engine => "/"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?

  mount Decidim::EphemeralParticipation::Engine, at: "/", as: "decidim_ephemeral_participation"
end

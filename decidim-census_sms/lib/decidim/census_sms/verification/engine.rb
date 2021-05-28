# frozen_string_literal: true

module Decidim
  module CensusSms
    module Verification
      # This is an engine that performs user authorization.
      class Engine < ::Rails::Engine
        isolate_namespace Decidim::CensusSms::Verification

        paths["db/migrate"] = nil
        paths["lib/tasks"] = nil

        routes do
          resource :authorizations, only: [:new, :create, :edit, :update, :destroy], as: :authorization do
            get :reset, on: :member
            post :reset, on: :member
            get :renew, on: :collection
          end
          root to: "authorizations#new"
        end

        initializer "decidim_census_sms.assets" do |app|
          app.config.assets.precompile += %w(decidim_census_sms_manifest.css
                                             decidim/census_sms/verification.scss)
        end
      end
    end
  end
end

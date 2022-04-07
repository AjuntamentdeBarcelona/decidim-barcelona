# frozen_string_literal: true

Decidim::ValidAuth::Engine.routes.draw do
  resource :authorizations, only: [:new], as: :authorization do
    collection do
      get :validate
    end
  end

  root to: "authorizations#new"
end

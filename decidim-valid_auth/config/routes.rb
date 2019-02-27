Decidim::ValidAuth::Engine.routes.draw do
  resource :authorizations, only: [:new, :create, :edit, :update], as: :authorization

  root to: "authorizations#new"
end

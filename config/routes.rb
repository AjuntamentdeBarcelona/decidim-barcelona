# frozen_string_literal: true
Rails.application.routes.draw do
  authenticate :user, lambda { |u| u.roles.include?("admin") } do
    mount Sidekiq::Web => '/sidekiq'
  end

  mount Decidim::Core::Engine => "/"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

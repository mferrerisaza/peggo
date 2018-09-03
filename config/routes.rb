Rails.application.routes.draw do
  devise_for :users
  root to: 'buildings#index'
  resources :buildings, only: [:index, :show, :new, :create] do
    resources :properties
    resources :owners, only: [:index, :show, :new, :create]
    resources :bills, only: [:new, :create]
  end
  resources :shares, only: [:create, :update, :destroy]
  require "sidekiq/web"
    authenticate :user, lambda { |u| u.admin } do
      mount Sidekiq::Web => '/sidekiq'
    end
end

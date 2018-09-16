Rails.application.routes.draw do
  devise_for :users
  root to: 'buildings#index'
  resources :buildings, only: [:index, :show, :new, :create] do
    resources :properties
    resources :owners
    resources :bills, only: [:new, :create]
    member do
      get 'bills/errors', to: "bills#errors"
    end
    resources :budgets, except: :show
  end
  resources :shares, only: [:create, :update, :destroy]
  require "sidekiq/web"
    authenticate :user, lambda { |u| u.admin } do
      mount Sidekiq::Web => '/sidekiq'
    end
end

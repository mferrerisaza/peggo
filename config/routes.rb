Rails.application.routes.draw do
  devise_for :users
  authenticated :user do
    root to: 'buildings#index'
  end
  root :to => 'pages#home'
  resources :buildings, only: [:index, :show, :new, :create] do
    resources :properties
    resources :owners
    resources :bills, only: [:new, :create]
    resources :budgets, except: :show
  end
  resources :shares, only: [:create, :update, :destroy]
  require "sidekiq/web"
    authenticate :user, lambda { |u| u.admin } do
      mount Sidekiq::Web => '/sidekiq'
    end
end

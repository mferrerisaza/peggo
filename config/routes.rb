Rails.application.routes.draw do
  authenticated :user do
    root to: 'buildings#index'
  end
  root to: 'pages#home'
  devise_for :users,
  controllers: { omniauth_callbacks: "users/omniauth_callbacks" }
  resources :buildings, only: [:index, :show, :new, :create] do
    resources :properties
    resources :owners
    resources :bills, only: [:index, :new, :create]
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

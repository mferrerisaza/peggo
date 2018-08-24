Rails.application.routes.draw do
  devise_for :users
  root to: 'buildings#index'
  resources :buildings, only: [:index, :show, :new, :create] do
    resources :properties
    resources :owners, only: [:index, :show, :new, :create]
  end
  resources :shares, only: [:create]
end

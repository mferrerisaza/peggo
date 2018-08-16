Rails.application.routes.draw do
  devise_for :users
  resources :owners
  root to: 'buildings#index'
  resources :buildings, only: [:index, :show, :new, :create] do
    resources :properties, only: [:index]
  end
end

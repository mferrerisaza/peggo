Rails.application.routes.draw do
  mount ForestLiana::Engine => '/forest'
  authenticated :user do
    root to: 'businesses#index'
  end
  root to: 'pages#home'
  devise_for :users,
  controllers: { omniauth_callbacks: "users/omniauth_callbacks" }
  resources :businesses do
    resources :contacts
    resources :expenses do
      member do
        get '/print', to: "expenses#print", defaults: { format: 'pdf' }
      end
    end
    resources :invoices do
      member do
        get '/print', to: "invoices#print", defaults: { format: 'pdf' }
      end
    end
    resources :items, only: [:create, :update, :destroy]
  end

  require "sidekiq/web"
    authenticate :user, lambda { |u| u.admin } do
      mount Sidekiq::Web => '/sidekiq'
    end
  get '/support', to: "pages#support"
end

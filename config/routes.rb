Rails.application.routes.draw do
  authenticated :user do
    root to: 'businesses#index', as: :authenticated_root
  end
  unauthenticated :user do
    root to: 'pages#home'
  end
  devise_for :users,
  controllers: { omniauth_callbacks: "users/omniauth_callbacks" }
  resources :businesses do
    resources :items, only: :index, to: "businesses#items"
    resources :contacts do
      member do
        get '/invoices', to: "contacts#invoices", defaults: { format: 'pdf' }
      end
    end

    resources :expenses do
      member do
        get '/print', to: "expenses#print", defaults: { format: 'pdf' }
        post :toggle_printed
      end
    end

    resources :expenses do
      member do
        get '/print', to: "expenses#print", defaults: { format: 'pdf' }
        post :toggle_printed
      end
    end

    resources :invoices do
      member do
        get '/print', to: "invoices#print", defaults: { format: 'pdf' }
        post :toggle_printed
      end
    end

    resources :payments do
      member do
        get '/print', to: "payments#print", defaults: { format: 'pdf' }
        post :toggle_printed
      end
    end

    resources :invoice_equivalents do
      member do
        get '/print', to: "invoice_equivalents#print", defaults: { format: 'pdf' }
        post :toggle_printed
      end
    end

    resources :attachments, only: :show
    resources :exports, only: [:new, :create]
  end

  require "sidekiq/web"
  authenticate :user, lambda { |u| u.admin } do
    mount Sidekiq::Web => '/sidekiq'
  end
end

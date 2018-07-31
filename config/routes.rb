Rails.application.routes.draw do
  get 'messages/index'

  get 'conversations/index'

  scope ":locale", locale: /#{I18n.available_locales.join("|")}/ do
    get "/signup", to: "users#new"
    root "static_pages#home"
    resources :users do
      member do
        get :following, :followers
      end
    end
    resources :reports do
      member do
        patch :approve
        patch :reject
      end
    end
    resources :conversations, only: [:index, :create] do
      resources :messages, only: [:index, :create]
    end
    resources :requests do
      member do
        post :verify
        post :reject
      end
    end
    resources :relationships,only: [:create, :destroy]
    resources :user_skills
    get 'static_pages/contact'
    get '/login', to: 'sessions#new'
    post '/login', to: 'sessions#create'
    delete '/logout', to: 'sessions#destroy'
    namespace :admin do
      root 'admin#index',as: :root
      resources :users,only: [:index,:destroy, :show, :update,:edit] do
        collection do
          post :import
        end
      end
      resources :divisions
      resources :positions
    end
  end
  get "auth/:provider/callback", to: "sessions#callback"
  get "auth/failure", to: redirect("/")
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
   match '*.path', to: redirect("/#{I18n.default_locale}/%{path}"), :via => [:get, :post]
   match '', to: redirect("/#{I18n.default_locale}"), :via => [:get, :post]
   match "/404", :to => "errors#not_found", :via => :all
   match "/500", :to => "errors#internal_server_error", :via => :all
end

Rails.application.routes.draw do
  scope ":locale", locale: /#{I18n.available_locales.join("|")}/ do
    get "/signup", to: "users#new"
    root "static_pages#home"
    resources :relationships,only: [:create, :destroy]
    resources :users do
      member do
        get :following, :followers
      end
    end
    resources :reports do
      member do
        post :approve
        post :reject
      end
    end
    resources :requests do
      member do
        post :verify
        post :reject
      end
    end
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
end

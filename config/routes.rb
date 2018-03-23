Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root to: "posts#index"

  resources :sessions, only: [:new, :create, :destroy]
  get '/login', to: "sessions#new", as: :login
  match '/logout', to: "sessions#destroy", via: [:get, :delete], as: :logout

  match "/auth/:provider/callback", :to => 'sessions#create', via: :all

  resources :posts do
    resources :comments, only: [:index, :create, :destroy], shallow: true
  end
  post "/posts/preview", to: "posts#preview"
  resource :archive, only: [:show]

  resources :invitations, only: [:edit, :update, :new, :create]

  # feed
  get 'feed', to: 'posts#index', constraints: lambda { |req| req.format = :atom }
  get '/tag/:tag', to: 'posts#index', as: :tag
end

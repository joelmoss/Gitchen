Gitchen::Application.routes.draw do

  match '/auth/:provider/callback' => 'sessions#create'
  match '/auth/failure' => 'sessions#failure'
  get 'sign_in', to: 'sessions#new', as: :sign_in
  delete 'sign_out', to: 'sessions#destroy', as: :sign_out

  resources :repos, only: [ :index ]
  get 'repos/:owner/:id' => 'repos#show', as: :repo
  delete 'repos/:owner/:id' => 'repos#unwatch', as: :unwatch_repo

  resources :languages, :users, :searches, only: [ :index, :show ]

  root to: "pages#index"

  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'

end

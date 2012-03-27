Gitchen::Application.routes.draw do

  match '/auth/:provider/callback' => 'sessions#create'
  match '/auth/failure' => 'sessions#failure'
  get 'sign_in', :to => 'sessions#new', :as => :sign_in
  delete 'sign_out', :to => 'sessions#destroy', :as => :sign_out


  root :to => "dashboards#index"

end

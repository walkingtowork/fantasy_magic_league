FantasyMagicLeague::Application.routes.draw do
  get "home/index"

  resources :players

  get "leagues/:id/start_draft" => 'leagues#start_draft', :as => :start_draft
  get "leagues/:id/draft" => 'leagues#draft', :as => :draft
  put "leagues/:id/add_user" => 'leagues#add_user', :as => :add_user
  put "leaves/:id/select_player" => 'leagues#select_player', :as => :select_player
  resources :leagues

  root :to => 'home#index'
  resources :user_sessions
  resources :users

  match 'login' => 'user_sessions#new', :as => :login
  match 'logout' => 'user_sessions#destroy', :as => :logout
end

FantasyMagicLeague::Application.routes.draw do
  get "home/index"

  get "tournaments" => 'tournaments#index', :as => :tournaments
  get "tournaments/new" => 'tournaments#new', :as => :new_tournament
  post "tournaments" => 'tournaments#create'

  resources :players

  get "leagues/:id/start_draft" => 'leagues#start_draft', :as => :start_draft
  get "leagues/:id/draft" => 'leagues#draft', :as => :draft
  put "leagues/:id/add_user" => 'leagues#add_user', :as => :add_user
  put "leagues/:id/select_player" => 'leagues#select_player', :as => :select_player
  resources :leagues


  resources :users
  resources :user_sessions

  match 'login' => 'user_sessions#new', :as => :login
  match 'logout' => 'user_sessions#destroy', :as => :logout

  root :to => 'home#index'
end

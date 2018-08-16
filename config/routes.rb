Rails.application.routes.draw do

  resources :users
  resources :books
  resources :authors do
    resources :books
  end
  resources :reviews
  resources :genres

  get '/signup' => "users#new"
  post '/users' => "users#create"
  get '/login' => "sessions#new"
  post '/login' => "sessions#create"
  post '/logout' => "sessions#destroy"

  get '/auth/facebook/callback' => 'sessions#create'

  root 'users#home'
end

Rails.application.routes.draw do

  resources :users
  resources :books
  resources :authors do
    resources :books
  end
  resources :reviews
  resources :genres

  get '/login' => "sessions#new"
  post '/users/:id' => "sessions#create"
  post '/' => "sessions#destroy"

  get '/auth/facebook/callback' => 'sessions#create'

  root 'users#home'
end

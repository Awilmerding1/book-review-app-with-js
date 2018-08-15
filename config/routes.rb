Rails.application.routes.draw do

  resources :users
  resources :books
  resources :authors do
    resources :books
  end
  resources :reviews
  resources :genres

  get '/login' => "sessions#new"
  post '/users' => "sessions#create"
  post '/' => "sessions#destroy"

  root 'users#home'
end

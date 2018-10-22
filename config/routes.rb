Rails.application.routes.draw do

  get '/users/most-reviews' => 'users#most_reviews'

  resources :books do
    resources :reviews
  end

  resources :reviews, only: [:create, :update]

  resources :users 

  resources :authors

  resources :genres

  # get '/reviews' => "users#show"
  get '/signup' => "users#new"
  post '/users' => "users#create"
  get '/login' => "sessions#new"
  post '/login' => "sessions#create"
  post '/logout' => "sessions#destroy"
  get '/auth/facebook/callback' => 'sessions#create'
  root 'users#home'

end

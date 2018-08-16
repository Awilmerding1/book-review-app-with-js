Rails.application.routes.draw do

  resources :reviews, only: [:create]

  resources :books do
    resources :reviews
  end
  resources :users do
    resources :reviews
  end
  resources :books
  resources :authors do
    resources :books
  end

  resources :genres

  get '/signup' => "users#new"
  post '/users' => "users#create"
  get '/login' => "sessions#new"
  post '/login' => "sessions#create"
  post '/logout' => "sessions#destroy"
  get "/books/:id/reviews/new" => "reviews#new"
  get "/book/:id/reviews/:id" => "reviews#show"
  post "/books/:id/reviews/:id" => "reviews#create"
  get "/book/:id/reviews" => "reviews#index"
  get '/auth/facebook/callback' => 'sessions#create'

  root 'users#home'
end

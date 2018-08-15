Rails.application.routes.draw do

  resources :users
  resources :books
  resources :authors do
    resources :books
  end
  resources :reviews
  resources :genres

  root 'users#home'
end

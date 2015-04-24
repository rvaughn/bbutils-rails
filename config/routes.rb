Rails.application.routes.draw do
  root to: 'stats#index'
  devise_for :users
  resources :users
  resources :repositories
  resources :members
  resources :groups
end

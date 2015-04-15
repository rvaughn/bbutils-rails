Rails.application.routes.draw do
  root to: 'visitors#index'
  devise_for :users
  resources :users
  get '/repositories', to: 'repositories#index'
  get '/members', to: 'members#index'
  get '/groups', to: 'groups#index'
end

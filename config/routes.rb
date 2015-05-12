Rails.application.routes.draw do
  root to: 'stats#index'
  devise_for :users, path_names: { sign_in: 'login', sign_out: 'logout' }
  devise_scope :user do
    get "login", to: "devise/sessions#new"
  end
  resources :users
  resources :repositories
  resources :members
  resources :groups
end

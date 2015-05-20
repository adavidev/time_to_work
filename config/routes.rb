Rails.application.routes.draw do
  resources :tasks

  root to: 'tasks#index'
  devise_for :users
  resources :users
end

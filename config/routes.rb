Rails.application.routes.draw do
  devise_for :users
  root to: 'users#index'
  resources :books, only: [:new, :create, :index, :show, :destroy]
  resources :users, only: [:show, :edit, :update, :index]
end

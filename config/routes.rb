Rails.application.routes.draw do
  get 'home/about' => 'homes#top'
  root to: 'books#top'
  devise_for :users

  resources :users, only: [:show, :edit, :update, :index]
  resources :books, only: [:create, :index, :show, :destroy, :update, :edit] do
    resource :favorites, only: [:create, :destroy]
    
 end
end

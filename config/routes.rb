Rails.application.routes.draw do
  

  resources :notifications, only: :index
  resources :posts, only: [:create, :destroy]
  resources :likes, only: [:index, :create, :destroy]
  resources :friendships, only: [:create, :update, :destroy]
  
  devise_for :users

  resources :users, only: [:index, :show]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'static_pages#home'

  get '/home', to: 'static_pages#home'

end

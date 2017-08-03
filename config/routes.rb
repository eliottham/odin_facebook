Rails.application.routes.draw do
  

  resources :notifications, only: :index
  OdinFacebook::Application.routes.draw do
  	resources :posts, only: [:create, :destroy] do
  		resources :likes, only: [:index, :create]
  		resources :comments, only: [:index, :create]
  	end
  end
  
  resources :likes, only: :destroy
  resources :comments, only: :destroy
  resources :friendships, only: [:create, :update, :destroy]

  devise_for :users

  resources :users, only: [:index, :show]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'static_pages#home'

  get '/home', to: 'static_pages#home'

end

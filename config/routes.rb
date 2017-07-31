Rails.application.routes.draw do
  

  get 'friendships/create'
  get 'friendships/update'
  get 'friendships/destroy'
  
  devise_for :users

  resources :users, only: [:index, :show]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'static_pages#home'

  get '/home', to: 'static_pages#home'

end

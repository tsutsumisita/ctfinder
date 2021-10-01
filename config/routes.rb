Rails.application.routes.draw do
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
  # root path
  root 'static_pages#home'
  
  resources :users, only: [:show, :create]
  resources :tournaments, only: [:show]
  
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'

end
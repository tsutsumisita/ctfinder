Rails.application.routes.draw do
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
  # root path
  root 'static_pages#home'
  
  resources :users, only: [:show, :create, :new]
  resources :tournaments, only: [:index, :show]
  
  get   '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'

  post    '/users/:liked_id/like',  to: 'likes#create', liked_id: /\d+/
  post    '/tournaments/:id/post',  to: 'posts#create', id: /\d+/
  
  get '/users/:id/direct_messages', to: 'direct_messages#show'
  post '/users/:id/direct_messages', to: 'direct_messages#create'
 
  get '/all_users' , to: 'users#all_users'
end

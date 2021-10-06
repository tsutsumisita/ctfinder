Rails.application.routes.draw do
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
  # root path
  root 'static_pages#home'
  
  resources :users, only: [ :create, :show,:new, :index]
  resources :tournaments, only: [:index, :show]
  
  get   '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'

  # users
  post    '/users/:liked_id/like',  to: 'likes#create', liked_id: /\d+/
  post '/users/search', to: 'users#search'
  get '/users/:id/direct_messages', to: 'direct_messages#show'
  post '/users/:id/direct_messages', to: 'direct_messages#create'
  
  # tournaments
  post    '/tournaments/:id/post',  to: 'posts#create', id: /\d+/
  post  '/tournaments/join',  to: 'tournaments#join'

end

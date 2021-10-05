Rails.application.routes.draw do
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
  # root path
  root 'static_pages#home'
  
  resources :users, only: [:show, :create, :new, :index]
  resources :tournaments, only: [:index, :show]
  
  get   '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'

  post    '/users/:liked_id/like',  to: 'likes#create', liked_id: /\d+/
  post    '/tournaments/:id/post',  to: 'posts#create', id: /\d+/
<<<<<<< HEAD
  post '/users/search', to: 'users#search'
  get '/users/:id/direct_massages', to: 'direct_messages#show'
=======
  
  get '/users/:id/direct_messages', to: 'direct_messages#show'
>>>>>>> 5cb5a42f57436edd7e48d692e4ccbbb66978c842
  post '/users/:id/direct_messages', to: 'direct_messages#create'
end

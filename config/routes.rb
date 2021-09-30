Rails.application.routes.draw do
  get 'static_pages/home'
  get 'users/new'
  get 'users/edit'
  get 'users/show'
  get 'users/create'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'static_pages#home'
end

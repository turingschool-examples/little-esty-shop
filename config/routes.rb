Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # LET'S CHOOSE ONE OF THE BELOW, RESOURCES OR BASIC
  get 'merchant/:merchant_id/items', to: 'merchant_items#index'
  patch 'merchant/:merchant_id/items', to: 'merchant_items#update'

  post 'merchant/:merchant_id/items', to: 'items#create'
  get 'merchant/:merchant_id/items/new', to: 'items#new'
  get '/merchant/:merchant_id/items/:item_id', to: 'items#show'
  get '/merchant/:merchant_id/items/:item_id/edit', to: 'items#edit'
  patch '/merchant/:merchant_id/items/:item_id', to: 'items#update'
  # SEE COMMENT ABOVE. CHOOSE RESOURCES OR BASIC, NOT BOTH
  resources :merchants, only: [:index, :show] do
    resources :items, only: [:index]
    resources :invoices, only: [:index]
    resources :dashboard, only: [:index], path: '/dashboard'
  end

  # WHY DO WE HAVE THESE? CAN WE DELETE? (-ADAM)
  resources :items
  resources :invoices

  # ADMIN DASHBOARD ROUTE
  resources :admin, :only => [:index]

  namespace :admin do
    resources :merchants, :except => [:destroy]
    resources :invoices, :except => [:new, :create, :destroy]
  end

end
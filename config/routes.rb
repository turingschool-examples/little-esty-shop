Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html


  get 'merchant/:merchant_id/items', to: 'merchant_items#index'
  patch 'merchant/:merchant_id/items', to: 'merchant_items#update'

  post 'merchant/:merchant_id/items', to: 'items#create'
  get 'merchant/:merchant_id/items/new', to: 'items#new'
  get '/merchant/:merchant_id/items/:item_id', to: 'items#show'
  get '/merchant/:merchant_id/items/:item_id/edit', to: 'items#edit'
  patch '/merchant/:merchant_id/items/:item_id', to: 'items#update'

  resources :merchants, only: [:index, :show] do
    resources :items, only: [:index]
    resources :invoices, controller: "invoices", only: [:index]
    resources :dashboard, only: [:index], path: '/dashboard'
  end

  resources :items

  resources :invoices

  # admin dashboard routes
  resources :admin, :only => [:index]

  namespace :admin do
    resources :merchants, :except => [:destroy]
    resources :invoices, :except => [:new, :create, :destroy]
  end

end

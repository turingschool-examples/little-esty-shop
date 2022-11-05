Rails.application.routes.draw do

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
    
  # admin
  get '/admin', to: 'admin#index'

  # merchants
  # get '/merchants/:merchant_id/dashboard', to: 'merchants#show'

  namespace :admin do
    resources :invoices, only: [:index, :show]
  end

  resources :merchants, only: [] do
    resources :items, only: [:index, :show, :edit, :new, :create]
    resources :item_status, only: [:update]
    resources :invoices, only: [:index]
    resources :invoices, only: [:show], controller: 'merchant_invoices'
  end

  patch "merchants/:merchant_id/items/:id", to: 'items#update'
end

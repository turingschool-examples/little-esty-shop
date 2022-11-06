Rails.application.routes.draw do
  namespace :admin do
    resources :merchants, only: [:index, :create, :new, :show, :edit, :update]
  end

  # admin
  get '/admin', to: 'admin#index'

  # merchants
  get '/merchants/:merchant_id/dashboard', to: 'merchants#show'

  resources :merchants, only: [] do
    resources :items, only: [:index, :show, :edit, :new, :create]
    resources :item_status, only: [:update]
    resources :invoices, only: [:index]
    resources :invoices, only: [:show], controller: 'merchant_invoices'
  end

  patch 'merchants/:merchant_id/items/:id', to: 'items#update'
end

Rails.application.routes.draw do
  # admin
  get '/admin', to: 'admin#index'

  namespace :admin do
    resources :merchants, only: [:index, :create, :new, :show, :edit, :update]
  end

  namespace :admin do
    resources :invoices, only: [:index, :show, :update]
  end

  # merchants
  get '/merchants/:merchant_id/dashboard', to: 'merchants#show'
  patch 'merchants/:merchant_id/items/:id', to: 'items#update'

  resources :merchants, only: [] do
    resources :items, only: [:index, :show, :edit, :new, :create]
    resources :item_status, only: [:update]
    resources :invoices, only: [:index, :show, :update]
  end
end

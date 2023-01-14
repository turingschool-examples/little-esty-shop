Rails.application.routes.draw do
  root 'home#index'

  resources :merchants, only: [] do
    resources :items, except: [:destroy]
    resources :invoices, only: [:index, :show]
    resources :invoice_items, only: [:update]
    patch "invoices/:invoice_id", to: 'invoice_items#update'
  end
  
  resources :admin, only: [:index]

  namespace :admin do
    resources :merchants, except: [:destroy]
    resources :invoices, only: [:index, :show, :update]
  end
  
  get '/merchants/:merchant_id/dashboard', to: 'merchants#show'
  patch '/merchants/:merchant_id/items', to: 'items#update'

  # patch "/merchants/:merchant_id/invoices/:invoice_id", to: 'invoice_items#update'
end

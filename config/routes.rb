Rails.application.routes.draw do
  resources :merchants do
    resources :items, controller: 'merchant_items'
  end
  get '/items/:id', to: 'items#show'
  patch 'items/:id', to: 'items#update_status'
  get '/merchant/:id/dashboard', to: 'merchants#show'

  get '/merchants/:id/invoices', to: 'merchant_invoices#index'
  get '/merchants/:id/items', to: 'merchant_items#index'
  get '/merchant/:id/invoices', to: 'merchant_invoices#index'

  get '/merchant/:merchant_id/invoices/:invoice_id', to: 'merchant_invoices#show'
  patch '/merchant/:merchant_id/invoices/:invoice_id', to: 'merchant_invoices#update'
  get '/merchants/:id/items/:item_id', to: 'merchant_items#show'
  get '/invoices/:id', to: 'invoices#show'

  get '/admin', to: 'admin#show'









end

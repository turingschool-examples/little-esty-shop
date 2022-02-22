Rails.application.routes.draw do
  resources :merchants do
    resources :items, controller: 'merchant_items'
  end
  get '/merchant/:id/dashboard', to: 'merchants#show'

  get '/merchant/:id/invoices', to: 'merchant_invoices#index'


  get '/merchants/:id/items', to: 'merchant_items#index'

  get '/merchant/:id/invoices', to: 'merchant_invoices#index'
  get '/merchant/:merchant_id/invoices/:invoice_id', to: 'merchant_invoices#show'

  get '/items/:id', to: 'items#show'
  patch 'items/:id', to: 'items#update_status'

  get '/merchants/:id/items/:item_id', to: 'merchant_items#show'

end

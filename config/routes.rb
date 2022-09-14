Rails.application.routes.draw do
  resources :transactions
  resources :invoice_items
  resources :items
  resources :merchants
  resources :invoices
  resources :customers
  
  get '/merchants/:id/dashboard', to: 'merchants#dashboard'
  get '/merchants/:id/items', to: 'merchants#items_index'
  get '/merchants/:id/items/:id', to: 'merchants#items_show'
  get '/merchants/:merchant_id/items/:merchant_item_id/edit', to: 'merchants#items_edit'
  patch '/merchants/:id/items/:id', to: 'merchants#items_update'


  namespace :admin do
    resources :invoices, only: %i[index show update]
  end 

  get '/merchants/:id/dashboard', to: 'merchants#dashboard'


end

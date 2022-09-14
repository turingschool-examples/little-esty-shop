Rails.application.routes.draw do
  resources :transactions
  resources :invoice_items
  resources :items
  resources :merchants
  resources :invoices
  resources :customers

  get '/merchants/:id/items', to: 'merchants#items_index'
  get '/merchants/:id/items/:id', to: 'merchants#items_show'
  get '/merchants/:id/dashboard', to: 'merchants#dashboard'
end

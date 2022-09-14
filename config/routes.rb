Rails.application.routes.draw do
  resources :transactions
  resources :invoice_items
  resources :items
  resources :merchants
  resources :invoices
  resources :customers


  get '/merchants/:id/dashboard', to: 'merchants#dashboard'
  
end

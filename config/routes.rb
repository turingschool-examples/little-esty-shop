Rails.application.routes.draw do
  resources :transactions
  resources :merchants
  resources :items
  resources :invoices
  resources :invoice_items
  resources :customers
  resources :admin, only: [:index]
end

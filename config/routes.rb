Rails.application.routes.draw do
  resources :transactions
  resources :invoice_items
  resources :items
  resources :merchants
  resources :invoices
  resources :customers

  namespace :admin do
    resources :invoices, only: %i[index show update]
  end 

  get 'merchants/:id/items', to: 'merchants#items_index'
end

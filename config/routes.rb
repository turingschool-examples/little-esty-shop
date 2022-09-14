Rails.application.routes.draw do
  resources :transactions
  resources :invoice_items
  resources :items
  resources :merchants
  resources :invoices
  resources :customers

  get 'merchants/:id/items', to: 'merchants#items_index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

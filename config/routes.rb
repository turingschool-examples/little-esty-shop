Rails.application.routes.draw do
  resources :transactions
  resources :invoices
  resources :customers
  resources :items
  resources :merchants
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

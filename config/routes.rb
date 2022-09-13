Rails.application.routes.draw do
  resources :transactions
  resources :merchants do
    resources :dashboards, only: [:index, :create]
    resources :items, only: [:index]
    resources :invoices, only: [:index]
  end
  resources :items
  resources :invoices
  resources :invoice_items
  resources :customers
end

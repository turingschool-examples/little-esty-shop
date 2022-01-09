Rails.application.routes.draw do

  resources :merchants do
    resources :dashboard, only: [:index]
    resources :items
    resources :invoices, only: [:index, :show]
    resources :invoice_items, only: [:update]
  end

  resources :transactions
  resources :customers
end

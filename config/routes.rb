Rails.application.routes.draw do
  resources :merchants do
    resources :dashboard, only: [:index]
    resources :items
    resources :invoices, only: [:index]
  end

  resources :transactions
  resources :customers
end

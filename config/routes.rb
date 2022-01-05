Rails.application.routes.draw do

  resources :merchants do
    resources :dashboards, only: [:index]

    resources :items
    resources :invoices
  end

  resources :transactions
  resources :customers


end

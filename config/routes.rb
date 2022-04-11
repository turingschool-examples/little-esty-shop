Rails.application.routes.draw do
  resources :merchants do
    resources :dashboard, controller: 'merchant_dashboard', only: [:index]
    resources :items, controller: 'merchant_items', only: [:index]
    resources :invoices, controller: 'merchant_invoices', only: [:index]
  end
end

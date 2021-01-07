Rails.application.routes.draw do
  namespace :admin do
    resources :merchants
    resources :invoices
  end

  resources :merchants do
    resources :items
    resources :invoices
    resources :dashboard, only: [:index]
  end

  resources :merchant_items, only: [:update], as: 'update_merchant_item'

  resources :admin, controller: 'admin/dashboard', only: [:index]
end

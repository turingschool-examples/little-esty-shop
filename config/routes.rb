Rails.application.routes.draw do
  get "/", to: "welcome#index"

  namespace :admin do
    resources :merchants
    resources :invoices
    get 'dashboard', to:'dashboard#index'
  end

  resources :merchants do
    resources :items, controller: 'merchant/items'
    resources :invoices, controller: 'merchant/invoices'
    get 'dashboard', to:'merchant/dashboard#show', on: :member
  end

  patch 'invoice_items/:id', to: 'invoice_items#update', as: 'update_invoice_item'
end

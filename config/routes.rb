Rails.application.routes.draw do
  root "welcome#index"
  
  resources :merchants do
    resources :items, except: [:destroy], controller: "merchants/items"
    resources :invoices, only: [:index, :show], controller: "merchants/invoices"
    resources :dashboard, only: [:index], controller: "merchants/dashboards"
    resources :invoice_items, only: [:update], controller: "merchants/invoice_items"
  end
  
  resources :admin, only: :index

  namespace :admin do
    resources :invoices, only: [:index, :show, :update]
    resources :merchants, except: [:destroy]
  end
end

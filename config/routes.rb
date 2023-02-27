Rails.application.routes.draw do
  resources :merchants do
    resources :items, except: [:destroy], controller: "merchants/items"
    resources :invoices, only: [:index, :show], controller: "merchants/invoices"
    resources :dashboard, only: [:index], controller: "merchants/dashboards"
  end
  
  resources :admin, only: :index

  namespace :admin do
    resources :invoices, only: [:index, :show]
    resources :merchants, except: [:destroy]
  end
end

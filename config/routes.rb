Rails.application.routes.draw do
  resources :merchants do
    resources :items, only: [:index], controller: "merchants/items"
    resources :invoices, only: [:index]
    resources :dashboard, only: [:index], controller: "merchants/dashboards"
  end
  
  resources :admin, only: :index

  namespace :admin do
    resources :invoices, only: [:index, :show]
    resources :merchants, except: [:destroy]
  end
end

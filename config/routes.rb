Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # get "/merchants/:merchant_id/dashboard", to: "merchants#dashboard"
  get '/', to: 'application#index'

  resources :merchants, only: :index do
    get "/dashboard", controller: :merchants, action: :show, as: "dashboard"
    resources :items, controller: :merchant_items
    resources :invoices, controller: :merchant_invoices
    resources :invoice_items, only: :update
  end

  resources :items
  resources :invoices


  namespace :admin do
    resources :dashboard, only: [:index]
    #get "/", to: 'dashboard#index', as: "dashboard"
    resources :merchants
    resources :invoices
  end
end

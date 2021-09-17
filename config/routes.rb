Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # get "/merchants/:merchant_id/dashboard", to: "merchants#dashboard"


  resources :merchants, only: :index do
    get "/dashboard", controller: :merchants, action: :show, as: "dashboard"
    resources :items, controller: :merchant_items
    resources :invoices, controller: :merchant_invoices
  end

  resources :items

  # resources :merchants do
  #   resources :invoices
  #   resources :dashboard, only: [:index]
  # end

  namespace :admin do
    resources :dashboard, only: [:index]
    #get "/", to: 'dashboard#index', as: "dashboard"
    resources :merchants
    resources :invoices
  end
end

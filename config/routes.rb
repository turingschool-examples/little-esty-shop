Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get "/", to: "application#welcome"

  resources :merchants, only: [:show] do
    resources :items, only: [:index, :show, :edit, :update, :new, :create]
    resources :invoices, only: [:index, :show]
    resources :invoice_items, only: [:update]
    resources :dashboard, only: [:index]
    resources :bulk_discounts, only: [:index, :show, :new, :create]
  end

  namespace :admin do
    get "/", to: "admin#dashboard"
    patch "/merchants/:id", to: "merchants#switch"
    resources :merchants, only: [:index, :show, :new, :create, :update, :edit]
    resources :invoices, only: [:index, :show, :update]
  end
end

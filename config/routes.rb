Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get "/merchants/:merchant_id/dashboard", to: "merchants#dashboard"
    # get "/merchants/:id/items", to: "merchants_items#index"
  resources :merchants do
    resources :items
    resources :dashboard, only: [:index]
  end

  resources :merchants do
    resources :invoices
    resources :dashboard, only: [:index]
  end

  namespace :admin do
    resources :dashboard, only: [:index]
    resources :merchants
    resources :invoices
  end
end

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get "/merchants/:merchant_id/dashboard", to: "merchants#dashboard"

  namespace :admin do
    resources :dashboard, only: [:index]
    resources :merchants
    resources :invoices
  end
end

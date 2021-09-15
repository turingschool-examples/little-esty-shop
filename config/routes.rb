Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :merchants do
    resources :items, controller: :merchant_items
    resources :invoices, controller: :merchant_invoices
  end

  namespace :admin do
    resources :merchants
    resources :invoices
    get '/', to: 'dashboard#index'
  end

  get "/merchants/:merchant_id/dashboard", to: "merchants#dashboard"
end

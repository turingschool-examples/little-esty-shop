Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  #merchants
  resources :merchants, only: [:show] do
    resources :items, only: [:index, :show], controller: "merchants/items"
    resources :invoices, only: [:index, :show], controller: "merchants/invoices"
    resources :dashboard, only: [:index], controller: "merchants/dashboard"
  end
end

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :admin, only: [:index] 

  resources :merchant, only: [:show] do
    resources :item, only: [:index], controller: "merchant_items"
    resources :invoices, only: [:index], controller: "merchant_invoices"
  end

  namespace :admin do
    resources :merchants, only: [:index]
    resources :invoices, only: [:index]
  end

  resources :merchants, only: [:show] do
    resources :dashboards, only: [:index]
  end
end

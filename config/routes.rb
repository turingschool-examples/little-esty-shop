Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html


  resources :admin, only: [:index] 

  resources :merchant, only: [:show] do
    resources :item, except: [:destroy], controller: "merchant_items"
    resources :invoices, only: [:index, :show], controller: "merchant_invoices"
  end

  namespace :admin do
    resources :merchants, only: [:index, :show]
    resources :invoices, only: [:index, :show]
  end

  resources :merchants, only: [:show] do
    resources :dashboards, only: [:index]
  end

  resources :invoices, only: [:show]
end

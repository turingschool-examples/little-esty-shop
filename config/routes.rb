Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :merchants, except: [:index, :new, :edit, :update, :destroy] do
    resources :dashboard, controller: :merchant_dashboard, only: [:index]
    resources :items, controller: :merchant_items, only: [:index, :show, :edit, :update, :new, :create]
    resources :invoices, controller: :merchant_invoices, only: [:index, :show]
  end
  
  resources :invoice_items, only: [:update]

  namespace :admin do
    get '/', to: 'dashboard#index'
    resources :items
    resources :invoices
    resources :merchants
  end
end

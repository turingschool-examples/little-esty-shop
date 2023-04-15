Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'application#welcome'
  
  resources :merchants, only: :index do
    get 'dashboard', action: :show, as: 'dashboard'
    resources :items, only: :index, as: 'items', controller: 'merchant/items'
    resources :invoices, only: :index, as: 'invoices', controller: 'merchant/invoices'
  end

  # get "/merchants/:merchant_id/items", to: "merchant/items#index", as: 'merchant_items'
  # get "/merchants/:merchant_id/invoices", to: "merchant/invoices#index", as: 'merchant_invoices'

  get '/admin', to: 'admin#index'

  resources :invoices, only: [:update]
  resources :merchants, only: [:update, :create, :new]

  namespace :admin do
    resources :merchants, except: [:destroy,:update]
    resources :invoices, only: [:index, :show, :update]
  end
  
end

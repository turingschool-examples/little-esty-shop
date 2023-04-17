Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'application#welcome'

  resources :merchants, only: [:index, :update] do
    get 'dashboard', action: :show, as: 'dashboard'
    resources :items, only: :index, as: 'items', controller: 'merchant/items'
    resources :invoices, only: [:index, :show], as: 'invoices', controller: 'merchant/invoices'
  end

  get '/admin', to: 'admin#index'

  resources :invoices, only: [:update]
  
  resources :invoice_items, only: [:update]
  
  resources :merchants, only: [:update, :create, :new]

  namespace :admin do
    resources :merchants, except: [:destroy,:update]
    resources :invoices, only: [:index, :show, :update]
  end

end

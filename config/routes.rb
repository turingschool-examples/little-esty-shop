Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # get "/admin", to: "admin/dashboard#index"
  # get "/admin/merchants", to: "admin/merchants#index"

  get '/', to: 'welcome#index', as: :root

  namespace :admin do
    root :to => 'dashboard#index'
    resources :merchants, except: [:destroy]
    resources :invoices, except: [:destroy]
  end

  resources :merchants do
    member { get "dashboard" }
    resources :items, only: [:index, :show, :edit, :update, :new, :create], controller: :merchant_items
    resources :invoices, only: [:index], controller: :merchant_invoices
    resources :invoice_items, only: [:update], controller: :merchant_invoice_items
    resources :discounts, controller: :merchant_discounts
  end

  namespace :merchants do
    resources :invoices, only: [:index]
  end

  get '/merchants/:id/dashboard', to: 'merchants#dashboard'
  get '/merchants/:id/invoices', to: 'merchant_invoices#index'
  get '/merchants/:id/invoices/:invoice_id', to: 'merchant_invoices#show'
  get '/github', to: 'github_api#show'
end

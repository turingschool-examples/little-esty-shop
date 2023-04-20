Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'welcome#index'
  get '/admin', to: 'admin#dashboard', as: 'admin_dashboard'
  get 'merchants/:id/dashboard', to: 'merchants#dashboard', as: 'merchant_dashboard'

  namespace :admin do
    resources :merchants, only: [:index, :show, :edit, :update]
    resources :invoices, only: [:index, :show, :update]
  end

  resources :merchants, only: [] do
    resources :items, except: [:destroy], controller: 'merchants/items'
    resources :invoices, only: [:index, :show, :update], controller: 'merchants/invoices'
  end

  resources :invoice_items, only: [:update], controller: 'merchants/invoice_items'
end

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :merchants, module: :merchant do
    # get '/dashboard', to: 'dashboard#show', as: 'merchant_dashboard'
    resources :dashboard, only: [:index]
    resources :items
    resources :invoices
    resources :invoice_items, only: [:update]
  end

  resources :admin, only: [:index]

  patch '/admin/merchants', to: 'admin/merchants#enable', as: 'enabled'

  namespace :admin do
    resources :merchants
    resources :invoices
  end
end

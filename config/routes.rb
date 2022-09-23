Rails.application.routes.draw do

  root to: 'welcome#index'

  
  resources :merchants, only: [:show], module: 'merchant' do
    resources :invoices, only: [:index, :show]
    resources :items, except: [:destroy]
    resources :invoice_items, only: [:update]
    resources :bulk_discounts, only: [:index]
  end
  
  get '/merchants/:merchant_id/dashboard', to: 'merchants#show'

  resources :admin, only: [:index]

  namespace :admin do
    resources :merchants, except: [:destroy]
    resources :invoices, only: [:index, :show, :update]
  end
end

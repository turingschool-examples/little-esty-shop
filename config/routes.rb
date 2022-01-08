Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
#heroku welcome page
root 'welcome#index'

get '/merchants/:merchant_id/dashboard', to: 'merchants#dashboard'
# get '/merchants/:merchant_id/items', to: 'merchant_items#index'

  resources :merchants, only: [:show] do
    resources :dashboard, only: [:index, :show]
    resources :items
    resources :invoices, only: [:index, :show]
    resources :invoice_items, only: :update
  end

  namespace :admin do
    root to: '/admin#index'
    resources :merchants, only: [:index, :show]
    resources :invoices, only: [:index, :show, :update]
  end

  # resources :admin, only: [:index]


end

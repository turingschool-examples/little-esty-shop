Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'welcome#index'
  # get "/admin/admin_merchants/:merchant_id", to: 'admin_merchant#show'
  # get '/admins', to: 'admins#index'
  # resources :merchants, only: [:show]
  namespace :admin do
    resources :dashboard, only: [:index]
    resources :merchants
    resources :invoices, only: [:show]
    # resources :customers
  end
  #
  resources :merchants do
    resources :dashboard, only: [:index]
    resources :items
    resources :invoices
  end
end

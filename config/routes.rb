Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # get "/admin", to: "admin/dashboard#index"
  # get "/admin/merchants", to: "admin/merchants#index"

  namespace :admin do
    root :to => 'dashboard#index'
    resources :merchants
    resources :invoices, only: [:index, :show]
  end
  resources :merchants do
    resources :items, only: [:index, :show], controller: :merchant_items
  end
  # '/merchants/:id/items', to: 'merchant'
  get '/merchants/:id/dashboard', to: 'merchants#dashboard'
  get '/github', to: 'github_api#show'
end

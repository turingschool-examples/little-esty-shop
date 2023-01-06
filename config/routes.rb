Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :admin, only: [:index]

  get '/merchants/:merchant_id/dashboard', to: 'merchant_dashboards#show', as: "merchants_merchantid_dashboard"

  resources :merchants, only: [:index, :show] do
    resources :items, :controller => :merchants_items, only: [:index, :show, :update, :edit]
    resources :invoices, only: [:index, :show]
  end

  resources :invoices, only: [:index]
  
  namespace :admin do
    resources :invoices, only: [:index, :show, :update]
    resources :merchants, only: [:index, :show, :update, :edit]
  end
end

Rails.application.routes.draw do
  resources :merchants do
    resources :items, only: [:index]
    resources :invoices, only: [:index]
    resources :dashboard, only: [:index], controller: "merchant_dashboards"
  end
  
  resources :admin, only: :index, controller: "admins"

  namespace :admin do
    resources :merchants, only: :index
  end

  namespace :admin do
    resources :invoices, only: [:index, :show]
  end
end

Rails.application.routes.draw do
  resources :merchants do
    resources :items, only: [:index]
    resources :invoices, only: [:index]
    resources :dashboard, only: [:index], controller: "merchant_dashboards"
  end
  
  resources :admin, only: :index

  namespace :admin do
    resources :invoices, only: [:index, :show]
    resources :merchants, only: [:index, :show, :edit, :update]
  end
end

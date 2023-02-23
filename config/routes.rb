Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :merchants, only: :show do 
    resources :dashboard, only: :index, controller: "merchants/dashboard"
    resources :items, only: :index, controller: "merchants/items"
  end

  resource :admin, only: :index do
    resources :merchants, only: :index, controller: "admin/merchant"
    resources :invoices, only: [:index, :show], controller: "admin/invoice"
  end
end
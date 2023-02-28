Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :merchants, only: :show do 
    resources :dashboard, only: :index, controller: "merchants/dashboard"
    resources :items, except: :destroy, controller: "merchants/items"
    resources :invoices, only: [:index, :show, :update], controller: "merchants/invoices"
  end
  
  namespace :admin do
    get '/', to: 'dashboard#index'
    resources :merchants, only: [:index, :show, :edit, :update]
    resources :invoices, only: [:index, :show, :update]
  end
end
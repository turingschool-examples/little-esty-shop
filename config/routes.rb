Rails.application.routes.draw do

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :admin do 
    resources :merchants, only: [:index, :show, :edit, :update] 
  end

  # admin
  get '/admin', to: 'admin#index'

  # merchants
  get '/merchants/:merchant_id/dashboard', to: 'merchants#show'

  resources :merchants, only: [] do
    resources :items, only: [:index, :show, :edit]
    resources :invoices, only: [:index]
    resources :invoices, only: [:show], controller: 'merchant_invoices'
  end

  patch "merchants/:merchant_id/items/:id", to: 'items#update'
end

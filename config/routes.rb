Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get '/merchants/:id/dashboard', to: 'merchants#dashboard'

  resources :merchants, except: [:index, :new, :edit, :update, :destroy] do
    resources :items, controller: :merchant_items, only: [:index]
    resources :invoices, controller: :merchant_invoices, only: [:index, :show]
  end

  namespace :admin do
    resources :items
    resources :invoices
    resources :merchants
  end
end

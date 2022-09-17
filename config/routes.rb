Rails.application.routes.draw do
  resources :transactions
  resources :invoice_items
  resources :items
  resources :merchants
  resources :invoices
  resources :customers

  resources :merchants do
    resources :items
  end
  get '/merchants/:id/dashboard', to: 'merchants#dashboard'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :admin do
   resources :invoices, only: [:index, :show, :update]
   resources :merchants, only: [:index, :show, :edit, :update]
 end
 
end

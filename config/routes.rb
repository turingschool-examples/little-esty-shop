Rails.application.routes.draw do
  resources :transactions
  resources :invoice_items
  resources :items
  resources :merchants
  resources :invoices
  resources :customers

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :merchants do
    resources :items
  end

  namespace :admin do
    get '/', to: 'admin#dashboard'
   resources :invoices, only: %i[index show update]
   resources :merchants, only: [:index, :show, :edit, :update]
 end

  get '/merchants/:id/dashboard', to: 'merchants#dashboard'
  get '/merchants/:id/items', to: 'merchant#items_index'

end

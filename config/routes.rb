Rails.application.routes.draw do
  resources :transactions
  resources :invoice_items
  resources :items
  resources :merchants
  resources :invoices
  resources :customers

  resources :merchants do
    resources :items
    resources :invoices, only: %i[index show update]
    resources :bulk_discounts, only: %i[index show edit update new destroy create]
  end

  namespace :admin do
    get '/', to: 'merchants#index'

    resources :invoices, only: %i[index show update]
    resources :merchants, only: [:index, :show, :edit, :update, :new, :create ]

   patch '/merchants/:id/update', to: 'merchants#update'
 end

  get '/merchants/:id/dashboard', to: 'merchants_dashboard#index'
  get '/merchants/:id/items', to: 'merchant#items_index'

end

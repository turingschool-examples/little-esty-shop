Rails.application.routes.draw do
  resources :transactions
  resources :invoice_items
  resources :items
  resources :merchants
  resources :invoices
  resources :customers
  
  get '/merchants/:id/dashboard', to: 'merchants#dashboard'
  get '/merchants/:id/items', to: 'merchants#items_index'
  get '/merchants/:merchant_id/items/:merchant_item_id', to: 'merchants#items_show'
  get '/merchants/:merchant_id/items/:merchant_item_id/edit', to: 'merchants#items_edit'
  patch '/merchants/:merchant_id/items/:merchant_item_id', to: 'merchants#items_update'

  patch '/merchants/:merchant_id/items/:merchant_item_id/disable', to: 'merchants#is_enabled?'
  patch '/merchants/:merchant_id/items/:merchant_item_id/enable', to: 'merchants#is_enabled?'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :admin do
   resources :invoices, only: [:index, :show, :update]
   resources :merchants, only: [:index, :show, :edit, :update]
 end

  get '/merchants/:id/dashboard', to: 'merchants#dashboard'



end

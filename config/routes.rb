Rails.application.routes.draw do
  resources :merchants do
    resources :items, only:[:index, :show], controller: 'merchant_items'
    resources :invoices, only:[:index, :show, :update], controller: 'merchant_invoices'
  end
  resources :items, only:[:show, :update]
  resources :invoices, only:[:show]

  get '/admin', to: 'admin#show'


namespace :admin do
  resources :merchants
  resources :invoices
end

  get '/', to: "welcome#index"

  #get '/items/:id', to: 'items#show'
  #patch 'items/:id', to: 'items#update_status'
  #get '/merchants/:id/dashboard', to: 'merchants#show'

  #get '/merchants/:id/invoices', to: 'merchant_invoices#index'
  #get '/merchants/:id/items', to: 'merchant_items#index'
  #get '/merchants/:id/invoices', to: 'merchant_invoices#index'

  #get '/merchants/:merchant_id/invoices/:invoice_id', to: 'merchant_invoices#show'
  #patch '/merchants/:merchant_id/invoices/:invoice_id', to: 'merchant_invoices#update'
  #get '/merchants/:id/items/:item_id', to: 'merchant_items#show'
  #get '/invoices/:id', to: 'invoices#show'










end

Rails.application.routes.draw do
  resources :merchants do
    resources :items, only:[:index, :show], controller: 'merchant_items'
    resources :invoices, only:[:index, :show, :update], controller: 'merchant_invoices'
  end
  resources :items, only:[:show, :update]
  resources :invoices, only:[:show]



namespace :admin do
  resources :merchants, :invoices
end

  get '/', to: "welcome#index"

  #get '/items/:id', to: 'items#show'
  #patch 'items/:id', to: 'items#update_status'
  #get '/merchant/:id/dashboard', to: 'merchants#show'

  #get '/merchants/:id/invoices', to: 'merchant_invoices#index'
  #get '/merchants/:id/items', to: 'merchant_items#index'
  #get '/merchant/:id/invoices', to: 'merchant_invoices#index'

  #get '/merchant/:merchant_id/invoices/:invoice_id', to: 'merchant_invoices#show'
  #patch '/merchant/:merchant_id/invoices/:invoice_id', to: 'merchant_invoices#update'
  #get '/merchants/:id/items/:item_id', to: 'merchant_items#show'
  #get '/invoices/:id', to: 'invoices#show'










end

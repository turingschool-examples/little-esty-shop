Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'welcome#index'
 #admins
 get '/admin', to: "admin#index"
 post '/merchants', to: "merchants#create"
  #merchants
  #customers
  #invoices
namespace :admin do 


  get '/merchants', to: "merchants#index"
  get '/merchants/new', to: "merchants#new"
  get '/merchants/:id', to: 'merchants#show'
  get '/merchants/:id/edit', to: "merchants#edit"
  patch '/merchants/:id', to: "merchants#update"

  # get "/invoices", to: "invoices#index"
  # get "/invoices/:invoice_id", to: "invoices#show"
  # resources :invoices, only: [:index, :show, :update]
  # get '/merchants', to: "merchants#index"
  # get '/merchants/:merchant_id', to: 'merchants#show'
  # post '/merchants/:merchant_id', to: 'merchants#edit'
  # get '/merchants/:merchant_id/edit', to: 'merchants#update'
  # resources :merchants, except: [:destroy]

  get "/invoices", to: "invoices#index"
  get "/invoices/:invoice_id", to: "invoices#show"
  
  get '/merchants', to: "merchants#index"
  get '/merchants/:merchant_id', to: 'merchants#show'
end 
  #transactions
  #items
  #invoice_items
  
 #merchants

#  namespace :merchants do 

#  end

  get "merchants/:merchant_id/dashboard", to: "merchants#dashboard"
 
  #customers
  #invoices
  get '/merchants/:merchant_id/invoices', to: 'merchants/invoices#index'
  get '/merchants/:merchant_id/invoices/:invoice_id', to: 'merchants/invoices#show'
  patch '/merchants/:merchant_id/invoices/:invoice_id', to: 'merchants/invoices#update'
  #transactions
  #items
  get '/merchants/:merchant_id/items/new', to: 'merchants/items#new'
  get '/merchants/:merchant_id/items', to: 'merchants/items#index'
  get '/merchants/:merchant_id/items/:item_id', to: 'merchants/items#show'
  get '/merchants/:merchant_id/items/:item_id/edit', to: 'merchants/items#edit'
  patch '/merchants/:merchant_id/items/:item_id', to: 'merchants/items#update'

  #invoice_items

 #customers



 #invoices



 #transactions



 #items

 get '/merchants/:merchant_id/items', to: 'merchants/items#index'
 get '/merchants/:merchant_id/items/new', to: 'items#new'
 post '/merchants/:merchant_id/items', to: 'items#create'
 patch 'items/:item_id', to: 'items#update'


 #invoice_items
end

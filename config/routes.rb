Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'welcome#index'
 #admins
 get '/admin', to: "admin#index"

  #merchants
  #customers
  #invoices
namespace :admin do 
  get "/invoices", to: "invoices#index"
  get "/invoices/:invoice_id", to: "invoices#show"
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
  get '/merchants/:merchant_id/invoices', to: 'invoices#index'
  get '/merchants/:merchant_id/invoices/:id', to: 'invoices#show'
   #transactions
  #items
  get '/merchants/:merchant_id/items', to: 'merchants/items#index'
  get '/merchants/:merchant_id/items/:item_id', to: 'merchants/items#show'
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

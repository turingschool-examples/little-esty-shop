Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'welcome#index'
 #admins
  #merchants
  #customers
  #invoices
  #transactions
  #items
  #invoice_items
  
 #merchants
  #customers
  #invoices
  #transactions
  #items
  get '/merchants/:merchant_id/items', to: 'merchants/items#index'
  get '/merchants/:merchant_id/items/:item_id', to: 'merchants/items#show'
  #invoice_items

 #customers



 #invoices



 #transactions



 #items



 #invoice_items
end

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
  get '/merchants/:merchant_id/invoices', to: 'invoices#index'
  get '/merchants/:merchant_id/invoices/:id', to: 'invoices#show'
   #transactions
  #items
  #invoice_items

 #customers



 #invoices



 #transactions



 #items



 #invoice_items
end

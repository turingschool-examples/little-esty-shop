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

#  namespace :merchants do 

#  end

get "merchants/:merchant_id/dashboard", to: "merchants#dashboard"
 
  #customers
  #invoices
  #transactions
  #items
  #invoice_items

 #customers



 #invoices



 #transactions



 #items



 #invoice_items
end

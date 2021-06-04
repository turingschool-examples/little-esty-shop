Rails.application.routes.draw do


  get "/merchants/:id/dashboard", to: "merchant/dashboard#index"
  get "/merchants/:id/items", to: "merchant/items#index"
  get "/merchants/:id/invoices",  to: "merchant/invoices#index"


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get '/merchants/:merchant_id/items', to: 'merchant_items#index'
  get '/merchants/:merchant_id/items/new', to: 'merchant_items#new'
  post '/merchants/:merchant_id/items', to: 'merchant_items#create'

  get '/admin', to: 'admin#index'

  get '/merchants/:merchant_id/items/:item_id', to: 'merchant_items#show'
  get '/merchants/:merchant_id/items/:item_id/edit', to: 'merchant_items#edit'
  patch '/merchants/:merchant_id/items/:item_id', to: 'merchant_items#update', as: 'item'
  get '/merchants/:merchant_id/invoices/:invoice_id', to: 'merchant/invoices#show'
  patch '/merchants/:merchant_id/invoices/:invoice_id', to: 'merchant/invoices#show'
  patch '/merchants/:merchant_id/items/:item_id', to: 'merchant_items#update'
end

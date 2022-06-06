Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/merchants/:id/dashboard', to: 'merchants#dashboard'
  get '/merchants/:id/invoices', to: 'merchant_invoices#index'
  get '/merchants/:id/invoices/:invoice_id', to: 'merchant_invoices#show'
  patch '/merchants/:id/invoices/:invoice_id', to: 'merchant_invoices#update'

  get '/merchants/:id/items', to: 'merchant_items#index'
  get '/merchants/:id/items/new', to: 'merchant_items#new'
  post '/merchants/:id/items', to: 'merchant_items#create'
  get '/merchants/:id/items/:item_id', to: 'merchant_items#show'
  get '/merchants/:id/items/:item_id/edit', to: 'merchant_items#edit'
  patch '/merchants/:id/items/:item_id', to: 'merchant_items#update'

end

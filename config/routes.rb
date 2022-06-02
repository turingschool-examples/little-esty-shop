Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/admin', to: 'admins#dashboard'
  get '/admin/merchants', to: 'admin_merchants#index'
  get '/admin/invoices', to: 'admin_invoices#index'

  get '/merchants/:id/dashboard', to: 'merchants#dashboard'
  get '/merchants/:id/invoices', to: 'merchant_invoices#index'
  get '/merchants/:id/invoices/:invoice_id', to: 'merchant_invoices#show'

  get '/merchants/:id/items', to: 'merchant_items#index'
  get '/merchants/:id/items/new', to: 'merchant_items#new'
  post '/merchants/:id/items', to: 'merchant_items#create'
  get '/merchants/:id/items/:item_id', to: 'merchant_items#show'
  get '/merchants/:id/items/:item_id/edit', to: 'merchant_items#edit'
  patch '/merchants/:id/items/:item_id', to: 'merchant_items#update'

end

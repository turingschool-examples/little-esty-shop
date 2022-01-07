Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/merchants/:id/items', to: 'merchant_items#index'
  get '/merchants/:merchant_id/items/:item_id', to: 'merchant_items#show'
  get '/merchants/:merchant_id/items/:item_id/edit', to: 'merchant_items#edit'
  patch '/merchants/:merchant_id/items/:item_id', to: 'merchant_items#update'

  get 'merchants/:id/invoices', to: 'merchant_invoices#index'
  get 'merchants/:merchant_id/invoices/:invoice_id', to: 'merchant_invoices#show'

  get '/merchants/:id/dashboard', to: 'merchants#dashboard'

  get '/admin', to: 'admin#dashboard'

  get '/admin/merchants', to: 'admin_merchants#index'

  get '/admin/invoices', to: 'admin_invoices#index'
  get '/admin/invoices/:id', to: 'admin_invoices#show'
end

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get '/merchants/:id/dashboard', to: 'merchants#show'

  get '/merchants/:id/invoices', to: 'invoices#index'
  get '/merchants/:merchant_id/invoices/:invoice_id', to: 'invoices#show'
  patch '/merchants/:merchant_id/invoices/:invoice_id', to: 'invoices#update'
  # patch '/invoice_items/:invoice_items_id', to: 'invoice_items#update'
end

Rails.application.routes.draw do
  get '/merchants/:merchant_id/items/:item_id', to: 'merchant_items#show'
  get '/merchants/:merchant_id/items/:item_id/edit', to: 'merchant_items#edit'
  patch '/merchants/:merchant_id/items/:item_id', to: 'merchant_items#update', as: 'item'
  get '/merchants/:merchant_id/invoices/:invoice_id', to: 'merchant/invoices#show'
  patch '/merchants/:merchant_id/invoices/:invoice_id', to: 'merchant/invoices#show'
end

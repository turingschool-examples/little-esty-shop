Rails.application.routes.draw do
  get '/merchants/:merchant_id/dashboard', to: 'merchants#show'
  get '/merchants/:merchant_id/items', to: 'merchant_items#index'
  get '/merchants/:merchant_id/invoices', to: 'merchant_invoices#index'

  get '/merchants/:merchant_id/items/:item_id', to: 'merchant_items#show'
end

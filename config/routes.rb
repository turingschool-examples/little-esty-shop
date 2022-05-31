Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/', to: 'application#welcome'

  get "/merchants/:merchant_id/dashboard", to: 'merchants#show'

  get "/merchants/:merchant_id/items", to: 'merchant_items#index'
  get "/merchants/:merchant_id/items/:item_id", to: 'merchant_items#show'
  get "/merchants/:merchant_id/items/:item_id/edit", to: 'merchant_items#edit'
  patch "/merchants/:merchant_id/items/:item_id", to: 'merchant_items#update'

  get "/merchants/:merchant_id/invoices", to: "merchant_invoices#index"
  get "/merchants/:merchant_id/invoices/:invoice_id", to: "merchant_invoices#show"
  patch "/merchants/:merchant_id/invoices/:invoice_id", to: "invoice_items#update"
end

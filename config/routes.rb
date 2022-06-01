Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/', to: 'application#welcome'

  get "/merchants/:merchant_id/dashboard", to: 'merchants#show'

  get "/merchants/:merchant_id/items", to: 'merchant_items#index'
  patch "/merchants/:merchant_id/items", to: 'merchant_items#update'

  get "/merchants/:merchant_id/items/:item_id", to: 'merchant_items#show'
  get "/merchants/:merchant_id/items/:item_id/edit", to: 'merchant_items#edit'
  patch "/merchants/:merchant_id/items/:item_id", to: 'merchant_items#update'

  get "/merchants/:merchant_id/invoices", to: "merchant_invoices#index"
  get "/merchants/:merchant_id/invoices/:invoice_id", to: "merchant_invoices#show"

  get "/admin", to: "admin#show"

  get '/admin/merchants/new', to: 'admin_merchants#new'
  post 'admin/merchants/new', to: 'admin_merchants#create'
  get "/admin/merchants/:merchant_id", to: 'admin_merchants#show'
  get "/admin/merchants/:merchant_id/edit", to: 'admin_merchants#edit'
  patch "/admin/merchants/:merchant_id", to: 'admin_merchants#update'

  get "/admin/merchants", to: "admin_merchants#index"

  get "/admin/invoices", to: "admin_invoices#index"
end

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/', to: 'application#welcome'
  get "/merchants/:merchant_id/dashboard", to: "merchants#show"
  get "/merchants/:merchant_id/items", to: "merchant_items#index"
  get "/merchants/:merchant_id/invoices", to: "merchant_invoices#index"

  get '/admin/invoices', to: 'admin/invoices#index'
  get '/admin/invoices/:id', to: 'admin/invoices#show'
  patch '/admin/invoices/:id', to: 'admin/invoices#update'

end

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get "/merchants/:merchant_id/dashboard", to: "merchant_dashboards#index"
  get "/merchants/:merchant_id/items", to: "merchant_items#index"
  get "/merchants/:merchant_id/items/:item_id", to: "merchant_items#show"
  get "/merchants/:merchant_id/invoices", to: "merchant_invoices#index"

  get "/merchants/:merchant_id/invoices/:invoice_id", to: "merchant_invoices#show"

  resources :admin, only: [:index]

  get '/admin/merchants', to: 'admin_merchants#index'
  get '/admin/invoices', to: 'admin_invoices#index'
  get '/admin/invoices/:id', to: 'admin_invoices#show'
  # namespace :admin do
  #   resources :merchants, only: [:index]
  #   resources :invoices, only: [:index]
  # end
end

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get "/merchants/:merchant_id/dashboard", to: "merchant_dashboards#index"
  get "/merchants/:merchant_id/items", to: "merchant_items#index"
  get "/merchants/:merchant_id/invoices", to: "merchant_invoices#index"

  get "/merchants/:merchant_id/invoices/:invoice_id", to: "merchant_invoices#show"

  resources :admin, only: [:index]

  get '/admin/merchants', to: 'admin_merchants#index'
  get '/admin/merchants/new', to: 'admin_merchants#new'
  post '/admin/merchants', to: 'admin_merchants#create'
  get '/admin/merchants/:id', to: 'admin_merchants#show', as: :admin_merchants_show
  get '/admin/merchants/:id/edit', to: 'admin_merchants#edit', as: :admin_merchants_edit
  patch '/admin/merchants/:id', to: 'admin_merchants#update'

  get '/admin/invoices', to: 'admin_invoices#index'
  get '/admin/invoices/:id', to: 'admin_invoices#show', as: :admin_invoices_show
  patch '/admin/invoices/:id', to: 'admin_invoices#update'
  # namespace :admin do
  #   resources :merchants, only: [:index]
  #   resources :invoices, only: [:index]
  # end
end

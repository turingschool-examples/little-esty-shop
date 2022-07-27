Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get 'merchants/:id/items', to: 'items#index'
  get 'merchants/:id/items/:id', to: 'items#show'

  get '/admin', to: 'admins#index'
  get '/admin/merchants', to: 'admin_merchants#index'
  get '/admin/merchants/:id', to: 'admin_merchants#show'
  get '/admin/invoices', to: 'admin_invoices#index'
  get '/admin/invoices/:id', to: 'admin_invoices#show'

  get "/merchants/:id/dashboard", to: "merchants#show"

  get '/merchants/:id/invoices', to: "invoices#index"

  get '/merchants/:id/invoices/:id', to: 'invoices#show'
  patch '/merchants/:id/invoices/:id', to: 'invoices#update'
end

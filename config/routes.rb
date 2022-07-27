Rails.application.routes.draw do

  get 'merchants/:id/items', to: 'items#index'
  get 'merchants/:id/items/:id', to: 'items#show'

  get '/admin', to: 'admins#index'
  get '/admin/merchants', to: 'admin_merchants#index'
  get '/admin/invoices', to: 'admin_invoices#index'
  get '/admin/invoices/:id', to: 'admin_invoices#show'

  get "/merchants/:id/dashboard", to: "merchants#show"
  get '/merchants/:id/invoices', to: "invoices#index"
end

Rails.application.routes.draw do

  get '/merchants/:id/items', to: 'items#index'
  patch '/merchants/:id/items', to: 'items#status'
  get '/merchants/:id/items/:id', to: 'items#show'
  get '/merchants/:id/items/:id/edit', to: 'items#edit'
  patch '/merchants/:id/items/:id', to: 'items#update'
  

  get '/admin', to: 'admins#index'
  get '/admin/merchants', to: 'admin_merchants#index'
  get '/admin/invoices', to: 'admin_invoices#index'

  get "/merchants/:id/dashboard", to: "merchants#show"
  get '/merchants/:id/invoices', to: "invoices#index"
end

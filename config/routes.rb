Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get "/admin", to: "admin#index"

  get "/admin/invoices", to: 'admin_invoices#index'
  get "/admin/invoices/:id", to: 'admin_invoices#show'
  patch "/admin/invoices/:id", to: 'admin_invoices#update'

  get "/admin/merchants", to: 'admin_merchants#index'
  get "/admin/merchants/new", to: 'admin_merchants#new'
  post "/admin/merchants/new", to: 'admin_merchants#create'
  get "/admin/merchants/:id", to: 'admin_merchants#show'
  get "/admin/merchants/:id/edit", to: 'admin_merchants#edit'
  patch "/admin/merchants/:id", to: 'admin_merchants#update'

  get "/merchant/:id/items", to: 'items#index'
  get "/merchant/:id/items/new", to: 'items#new'
  post "/merchant/:id/items/new", to: 'items#create'
  get "/merchant/:id/items/:id", to: 'items#show'
  get "/merchant/:id/items/:id/edit", to: 'items#edit'
  patch "/merchant/:id/items/:id", to: 'items#update'

  get "/merchants/:id/invoices", to: 'invoices#index'
  get "/merchants/:id/invoices/:id", to: 'invoices#show'
  
  # namespace :admin do
  #   resources :merchants
  #   resources :invoices
  # end
end

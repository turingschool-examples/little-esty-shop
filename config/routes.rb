Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get '/admin', to: 'admins#index'
  get '/admin/merchants', to: 'admin_merchants#index'
  get '/admin/invoices', to: 'admin_invoices#index'

  get "/merchants/:id/dashboard", to: "merchants#show"
  get "/merchants/:id/items", to: "items#index"
end

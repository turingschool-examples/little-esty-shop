Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get "/admin", to: "admin#index"

get "/admin/invoices", to: 'admin_invoices#index'
  get "/admin/invoices/:id", to: 'admin_invoices#show'

  get "/admin/merchants", to: 'admin_merchants#index'
  get "/admin/merchants/:id", to: 'admin_merchants#show'
  get "/admin/merchants/:id/edit", to: 'admin_merchants#edit'
  patch "/admin/merchants/:id", to: 'admin_merchants#update'

  # namespace :admin do
  #   resources :merchants
  #   resources :invoices
  # end

  get "/merchants/merchant_id/dashboard", to: 'merchant_dashboard#dashboard'
end

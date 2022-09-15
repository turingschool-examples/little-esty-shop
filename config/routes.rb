Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get "/admin", to: "admin#index"
  get "/admin/invoices", to: 'admin_invoices#index'

  get "/admin/merchants", to: 'admin_merchants#index'
  get "/admin/merchants/:id", to: 'admin_merchants#show'
  get "/admin/merchants/:id/edit", to: 'admin_merchants#edit'


  # namespace :admin do
  #   resources :merchants
  #   resources :invoices
  # end
end

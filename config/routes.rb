Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get "/admin", to: "admin#index"
  get "/admin/merchants", to: 'admin_merchants#index'
  get "/admin/invoices", to: 'admin_invoices#index'

end

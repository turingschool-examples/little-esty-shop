Rails.application.routes.draw do
  resources :customers
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/admin', to: 'admins#show'
  get '/admin/merchants', to: 'admins#merchant_index'
  get '/admin/invoices', to: 'admins#invoice_index'
end

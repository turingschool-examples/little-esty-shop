Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get '/', to: 'merchants#welcome'

  get "/merchant/:id/dashboard" to: 'merchants#show'
  get "/merchant/:id/items" to: 'merchants#item_index'
  get "/merchant/:merchant_id/items/:item_id" to: 'merchants#item_show'
  get "/merchant/:id/invoices" to: 'merchants#invoice_index'
  get "/merchant/:merchant_id/invoces/:invoice_id" to: 'merchants#invoice_show'

########## Admin routes below ############

  resources :admin, only: [:index]
  namespace :admin do
    resources :invoices, :merchants, only: [:index]
  end
end

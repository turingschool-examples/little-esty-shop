Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get '/', to: 'merchants#welcome'

  get "/merchants/:id/dashboard", to: 'merchants#show'
  get "/merchants/:id/items", to: 'merchants#item_index'
  get "/merchants/:merchant_id/items/:item_id", to: 'merchants#item_show'
  get "/merchants/:id/invoices", to: 'merchants#invoice_index'
  get "/merchants/:merchant_id/invoces/:invoice_id", to: 'merchants#invoice_show'

########## Admin routes below ############



end

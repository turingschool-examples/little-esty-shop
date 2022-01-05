Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/merchants/:id/items', to: 'merchant_items#index'
  get '/merchants/:merchant_id/items/:item_id', to: 'merchant_items#show'

  get 'merchants/:id/invoices', to: 'merchant_invoices#index'
  get 'merchants/:id/invoices/:id', to: 'invoices#show'

  get '/merchants/:id/dashboard', to: 'merchants#dashboard'

end

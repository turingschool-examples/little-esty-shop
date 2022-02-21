Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get '/merchants/:id/dashboard', to: 'merchants#show'


  get '/merchants/:id/invoices', to: 'invoices#index'
  get '/merchants/:id/invoices/:id', to: 'invoices#show'

  get '/merchants/:merchant_id/items', to: 'items#index'
  get '/merchants/:merchant_id/items/:item_id', to: 'items#show'
  get '/merchants/:merchant_id/items/:item_id/edit', to: 'items#edit'
  patch '/merchants/:merchant_id/items/:item_id', to: 'items#update'

  get 'admin/merchants', to: 'admin/merchants#index'
  # get 'admin/merchants/:id', to: 'admin/merchants#show'

end

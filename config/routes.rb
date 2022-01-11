Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # get '/merchants/:id/items', to: 'merchant_items#index'
  # get '/merchants/:merchant_id/items/:item_id', to: 'merchant_items#show'
  # get '/merchants/:merchant_id/items/:item_id/edit', to: 'merchant_items#edit'
  # patch '/merchants/:merchant_id/items/:item_id', to: 'merchant_items#update'
  resources :merchants do
    resources :items, controller: 'merchant_items'
  end


  scope '/admin', as: 'admin' do
    resources :merchants, controller: 'admin_merchants'
  end
  scope '/admin' do
    resources :invoices, controller: 'admin_invoices'
  end
  # resources :merchants do
  #   resources :invoices, controller: 'merchant_invoices'
  # end

  get 'merchants/:id/invoices', to: 'merchant_invoices#index'
  get 'merchants/:merchant_id/invoices/:invoice_id', to: 'merchant_invoices#show'
  patch '/merchants/:merchant_id/invoices/:invoice_id/:invoice_item_id', to: 'invoice_items#update'

  get '/merchants/:id/dashboard', to: 'merchants#dashboard'

  get '/admin', to: 'admin#dashboard'

#   unsure if we need this. Merging in github. Leland
  # get '/admin/merchants', to: 'admin_merchants#index'
  # get '/admin/merchants/:id', to: 'admin_merchants#show'
  # get '/admin/merchants/:id/edit', to: 'admin_merchants#edit'
  patch '/admin/merchants/:id', to: 'admin_merchants#update'
  #
  # get '/admin/invoices', to: 'admin_invoices#index'
  # get '/admin/invoices/:id', to: 'admin_invoices#show'

end

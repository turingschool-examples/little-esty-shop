Rails.application.routes.draw do
  resources :merchants do
    resources :items, controller: 'merchant_items'
  end

  scope '/admin', as: 'admin' do
    resources :merchants, controller: 'admin_merchants'
  end
  
  scope '/admin' do
    resources :invoices, controller: 'admin_invoices'
  end

  get 'merchants/:id/invoices', to: 'merchant_invoices#index'
  get 'merchants/:merchant_id/invoices/:invoice_id', to: 'merchant_invoices#show'
  patch '/merchants/:merchant_id/invoices/:invoice_id/:invoice_item_id', to: 'invoice_items#update'

  get '/merchants/:id/dashboard', to: 'merchants#dashboard'

  get '/admin', to: 'admin#dashboard'

  patch '/admin/invoices/:invoice_id/:invoice_item_id', to: 'admin_invoice_items#update'
end

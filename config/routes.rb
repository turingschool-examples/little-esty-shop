Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get '/', to: 'application#index'
  #BULK DISCOUNTS
  get '/merchants/:merchant_id/bulkdiscounts', to: 'bulkdiscounts#index'
  get '/merchants/:merchant_id/bulkdiscounts/new', to: 'bulkdiscounts#new'
  get '/merchants/:merchant_id/bulkdiscounts/:bulkdiscount_id', to: 'bulkdiscounts#show'
  post '/merchants/:merchant_id/bulkdiscounts', to: 'bulkdiscounts#create'
  delete '/merchants/:merchant_id/bulkdiscounts/:bulkdiscount_id', to: 'bulkdiscounts#destroy'
  get '/merchants/:merchant_id/bulkdiscounts/:bulkdiscount_id/edit', to: 'bulkdiscounts#edit'
  patch '/merchants/:merchant_id/bulkdiscounts/:bulkdiscount_id', to: 'bulkdiscounts#update'
  get '/merchants', to: 'merchants#index'

  resources :merchants do
    get '/invoices', to: 'merchant_invoices#index'
    get '/invoices/:invoice_id', to: 'merchant_invoices#show'
    patch '/invoices/:invoice_id', to: 'merchant_invoices#update'

    get "/items", to: "merchant_items#index"
    get '/items/new', to: 'merchant_items#new'
    post 'items', to: 'merchant_items#create'

    get '/items/:item_id', to: 'merchant_items#show'
    get '/items/:item_id/edit', to: 'merchant_items#edit'
    patch '/items/:item_id', to: 'merchant_items#update'
  end

  get '/merchants/:merchant_id/dashboard', to: 'merchant_dashboards#show'

  resources :admin, only: :index

  scope :admin, module: :admin do
    get '/invoices', to: 'invoices#index'
    get 'invoices/:id', to: 'invoices#show'
    patch '/invoices/:id', to: 'invoices#update'

    get '/merchants', to: 'merchants#index'
    get '/merchants/new', to: 'merchants#new'
    post '/merchants', to: 'merchants#create'
    get '/merchants/:id', to: 'merchants#show'
    get '/merchants/:id/edit', to: 'merchants#edit'
    patch '/merchants/:id', to: 'merchants#update'
  end

end

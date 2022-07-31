Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get '/', to: 'application#welcome'
  
  resources :merchants do
    get '/invoices', to: 'merchant_invoices#index'
    get '/invoices/:invoice_id', to: 'merchant_invoices#show'
    patch '/invoices/:invoice_id', to: 'merchant_invoices#update'
  end
  
  get "/merchants/:id/items", to: "merchant_items#index"
  get '/merchants/:id/items/new', to: 'merchant_items#new'
  post 'merchants/:id/items', to: 'merchant_items#create'
  
  get '/merchants/:id/items/:item_id', to: 'merchant_items#show'
  get '/merchants/:id/items/:item_id/edit', to: 'merchant_items#edit'
  patch '/merchants/:id/items/:item_id', to: 'merchant_items#update'
  
  get '/merchants/:merchant_id/dashboard', to: 'merchant_dashboards#show'

  scope :admin, module: :admin do
    get '/invoices', to: 'invoices#index'
    get 'invoices/:id', to: 'invoices#show'
    patch '/invoices/:id', to: 'invoices#update'
    get '/merchants', to: 'merchants#index'
    get '/merchants/:id', to: 'merchants#show'
    get '/merchants/:id/edit', to: 'merchants#edit'
    patch '/merchants/:id', to: 'merchants#update'
  end

end

Rails.application.routes.draw do
  get '/', to: 'welcome#index'

  get 'admin/invoices/:invoice_id', to: 'admin/invoices#show'

  namespace :merchants, module: :merchants do
    get ':id', to: 'dashboard#index'

    get ':id/items', to: 'items#index'
    get ':id/items/new', to: 'items#new'
    get ':merchant_id/items/:item_id', to: 'items#show'
    get ':merchant_id/items/:item_id/edit', to: 'items#edit'
    patch ':merchant_id/items/:item_id', to: 'items#update'
    post ':id/items', to: 'items#create'

    get ':id/invoices', to: 'invoices#index'
    get ':merchant_id/invoices/:invoice_id', to: 'invoices#show'
    patch ':merchant_id/invoices/:invoice_id', to: 'invoices#update'
  end

  namespace :admin, module: :admin do
    get '/', to: 'dashboard#index'
    resources :merchants, only:[:index, :new, :show, :create, :edit, :update]

    resources :invoices, only:[:index, :show, :update]
    # get '/merchants', to: 'merchants#index'
    # get '/merchants/new', to: 'merchants#new'
    # get '/merchants/:id', to: 'merchants#show'
    # post '/merchants/create', to: 'merchants#create'
    # get '/merchants/:id/edit', to: 'merchants#edit'
    # patch '/merchants/:id', to: 'merchants#updat
  end

end

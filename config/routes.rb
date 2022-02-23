Rails.application.routes.draw do
  get '/', to: 'welcome#index'

  namespace :merchants, module: :merchants do
    get ':id', to: 'dashboard#index'

    get ':id/items', to: 'items#index'
    get ':merchant_id/items/:item_id', to: 'items#show'
    get ':merchant_id/items/:item_id/edit', to: 'items#edit'
    patch ':merchant_id/items/:item_id', to: 'items#update'

    get ':id/invoices', to: 'invoices#index'
    get ':merchant_id/invoices/:invoice_id', to: 'invoices#show'
  end

  namespace :admin, module: :admin do
    get '/', to: 'dashboard#index'
    resources :merchants, only:[:index, :new, :show, :create, :edit, :update]

    resources :invoices, only:[:index, :show]
    # get '/merchants', to: 'merchants#index'
    # get '/merchants/new', to: 'merchants#new'
    # get '/merchants/:id', to: 'merchants#show'
    # post '/merchants/create', to: 'merchants#create'
    # get '/merchants/:id/edit', to: 'merchants#edit'
    # patch '/merchants/:id', to: 'merchants#updat
  end
end

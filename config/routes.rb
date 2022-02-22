Rails.application.routes.draw do
  get '/', to: 'welcome#index'

  scope :merchants, module: :merchants do
    get ':id/dashboard', to: 'dashboard#index'

    get ':id/items', to: 'items#index'
    get ':merchant_id/items/:item_id', to: 'items#show'
    get ':merchant_id/items/:item_id/edit', to: 'items#edit'
    patch ':merchant_id/items/:item_id', to: 'items#update'

    get ':id/invoices', to: 'invoices#index'
    get ':merchant_id/invoices/:invoice_id', to: 'invoices#show'
  end

  scope :admin, module: :admin do
    get '/', to: 'dashboard#index'
    get '/merchants', to: 'merchants#index'
    get '/merchants/new', to: 'merchants#new'
    get '/merchants/:id', to: 'merchants#show'
    post '/merchants', to: 'merchants#create'
    get '/merchants/:id/edit', to: 'merchants#edit'
    patch '/merchants/:id', to: 'merchants#update'
  end
end

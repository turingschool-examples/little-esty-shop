Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
    # resources :merchants do
    #   resources :items, only: [:index, :show]
    #   resources :invoices, only: [:index]
    #   resources :dashboard, only: [:index]
    # end

  get '/', to: 'application#welcome'

  get '/merchants/:merchant_id/items', to: 'items#index', as: 'merchant_items'
  get '/merchants/:merchant_id/items/:id', to: 'items#show', as: 'merchant_item'
  get '/merchants/:merchant_id/invoices', to: 'invoices#index', as: 'merchant_invoices'
  get '/merchants/:merchant_id/invoices/:id', to: 'invoices#show', as: 'merchant_invoice'
  get  '/merchants/:merchant_id/dashboard', to: 'dashboard#index', as: 'merchant_dashboard_index'
  # get  '/merchants', to: 'merchants#index', as: 'merchants'
  # post '/merchants', to: 'merchants#create'
  # get  '/merchants/new', to: 'merchants#new', as: 'new_merchant'
  # get  '/merchants/:id/edit', to: 'merchants#edit', as: 'edit_merchant'
  # get  '/merchants/:id', to: 'merchants#show', as: 'merchant'
  # patch '/merchants/:id', to: 'merchants#update'
  # put   '/merchants/:id', to: 'merchants#update'
  # delete '/merchants/:id', to: 'merchants#destroy'





















  get '/admin', to: 'admin/dashboard#index', as: 'admin'
  get '/admin/merchants', to: 'admin/merchants#index', as: 'admin_merchants'
  get '/admin/invoices', to: 'admin/invoices#index', as: 'admin_invoices'

  namespace :admin do
    get '/', to: "dashboard#index"
    resources :merchants, only: [:index, :show, :update]
    resources :invoices, only: [:index]
  end
end

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
    # resources :merchants do
    #   resources :items, only: [:index, :show]
    #   resources :invoices, only: [:index]
    #   resources :dashboard, only: [:index]
    # end

  get '/', to: 'application#welcome'

  get '/merchants/:merchant_id/items', to: 'items#index', as: 'merchant_items'
  get '/merchants/:merchant_id/items/new', to: 'items#new', as: 'item_create'
  get '/merchants/:merchant_id/items/:id', to: 'items#show', as: 'merchant_item'
  post '/merchants/:merchant_id/items', to: 'items#create'
  patch '/merchants/:id/items', to: 'items#update', as: 'item_update'

  get '/merchants/:merchant_id/invoices', to: 'invoices#index', as: 'merchant_invoices'
  get '/merchants/:merchant_id/invoices/:id', to: 'invoices#show', as: 'merchant_invoice'
  get  '/merchants/:merchant_id/dashboard', to: 'dashboard#index', as: 'merchant_dashboard_index'
  # get  '/merchants', to: 'merchants#index', as: 'merchants'
  # post '/merchants', to: 'merchants#create'
  # get  '/merchants/new', to: 'merchants#new', as: 'new_merchant'
  # get  '/merchants/:id/edit', to: 'merchants#edit', as: 'edit_merchant'
  # get  '/merchants/:id', to: 'merchants#show', as: 'merchant'
  # put   '/merchants/:id', to: 'merchants#update'
  # delete '/merchants/:id', to: 'merchants#destroy'







  namespace :admin do
    get '/', to: "dashboard#index"
    resources :merchants, only: [:index, :new, :create, :show, :edit, :update]
    resources :invoices, only: [:index, :show, :update]
  end
end

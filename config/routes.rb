Rails.application.routes.draw do
  get '/', to: 'application#welcome'

  resources :admin, only:[:index]


  namespace :admin do 
    resources :invoices, only: [:index, :show]
  end
  # resources :merchants, only:[:show] do
  #   resources :merchant_items, only:[:index]
  #   resources :dashboard, only:[:index]
  # # resources :invoices, only:[:index, :show]
  # end

  # resources :merchant do
  #   resources :items
  #   resources :items, controller: 'merchant_items', only:[:index, :show, :update, :edit]
  # end

  get '/merchants/:merchant_id/dashboard', to: 'dashboard#index'
  get '/merchants/:id', to: 'merchants#show'
  get '/merchants/:merchant_id/items', to: 'merchant_items#index'
  get 'merchants/:merchant_id/items/:id/edit', to: 'items#edit'
  patch '/merchants/:id/items/:id/', to: 'items#update'
  get 'merchants/:merchant_id/items/:id', to: 'items#show'
  get '/merchants/:id/invoices', to: 'merchants#show'
  get '/merchants/:id/invoices/:id', to: 'merchant_invoices#show'

  get '/admin/merchants', to: 'merchants#admin_index'
  get '/admin/merchants/:id', to: 'merchants#admin_show'
  patch '/admin/merchants/:id', to: 'merchants#update'
  # patch '/admin/merchants/:id', to: 'adminmerchants#update'
  get '/admin/merchants/:id/edit', to: 'merchants#edit'

  # get '/admin/invoices', to: 'invoices#admin_index'
end

Rails.application.routes.draw do

  get '/', to: "welcome#index"
  get "/merchants/:id/dashboard", to: "merchants#show"
  get '/merchants/:id/items/new', to: 'items#new'

  resources :merchants, except: [:show] do
    resources :items, only: [:index, :show, :edit, :update]
    resources :invoices, only: [:index, :show, :update]
  end

  namespace :admin do
    resources :invoices, only: [:index, :show, :update]
  end

  patch '/merchants/:id/items', to: 'items#status'

  post '/merchants/:id/items', to: 'items#create'
  
  get '/admin', to: 'admins#index'

  get '/admin/merchants/new', to: 'admin_merchants#new'
  get '/admin/merchants', to: 'admin_merchants#index'
  get '/admin/merchants/:id', to: 'admin_merchants#show'
  get '/admin/merchants/:id/edit', to: 'admin_merchants#edit'
  patch '/admin/merchants/:id', to: 'admin_merchants#update'
  patch '/admin/merchants', to: 'admin_merchants#index'
  post '/admin/merchants', to: 'admin_merchants#create'

  # get '/admin/invoices', to: 'admin_invoices#index'
  # get '/admin/invoices/:id', to: 'admin_invoices#show'

  # patch '/admin/invoices/:id', to: 'admin_invoices#update'
  
end

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'welcome#index'

  resources :admin, only: [:index]
  
  namespace :admin do 
    resources :invoices, only: [:index, :show, :update]
    resources :merchants, except: [:destroy]
  end 

  
  
  get "/merchants/:merchant_id/dashboard", to: "merchants#dashboard"
  
  get '/merchants/:merchant_id/invoices', to: 'merchants/invoices#index'
  get '/merchants/:merchant_id/invoices/:invoice_id', to: 'merchants/invoices#show'
  patch '/merchants/:merchant_id/invoices/:invoice_id', to: 'merchants/invoices#update'
  
  get '/merchants/:merchant_id/items/new', to: 'merchants/items#new'
  get '/merchants/:merchant_id/items', to: 'merchants/items#index'
  get '/merchants/:merchant_id/items/:item_id', to: 'merchants/items#show'
  get '/merchants/:merchant_id/items/:item_id/edit', to: 'merchants/items#edit'
  patch '/merchants/:merchant_id/items/:item_id', to: 'merchants/items#update'
  
  get '/merchants/:merchant_id/items', to: 'merchants/items#index'
  get '/merchants/:merchant_id/items/new', to: 'items#new'
  post '/merchants/:merchant_id/items', to: 'items#create'
  patch '/items/:item_id', to: 'items#update'
  
  post '/merchants', to: "merchants#create"
end

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'welcome#index'

  get "/merchants/:id/dashboard", to: "merchants#show"
  get '/merchants/:id/items', to: 'merchant_items#index'
  get '/merchants/:id/items/new', to: 'merchant_items#new'
  post '/merchants/:id/items/', to: 'merchant_items#create'

  get '/merchants/:id/items/:item_id', to: 'merchant_items#show'
  get '/merchants/:id/items/:item_id/edit', to: 'merchant_items#edit'
  patch '/merchants/:id/items/:item_id', to: 'merchant_items#update'

  get '/merchants/:id/invoices', to: 'merchant_invoices#index'
  get '/merchants/:id/invoices/:inv_id', to: 'merchant_invoices#show'

  resources :invoice_items, only: [:update]

  namespace :admin do
    get '/', to: 'base#show' #route for admin dashboard

    resources :merchants, only: [:index, :show, :edit, :update, :new, :create]
    
    get '/invoices', to: 'invoices#index'
    get '/invoices/:id', to: 'invoices#show'
    patch '/invoices/:id', to: 'invoices#update'
  end
end

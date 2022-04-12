Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get '/' ,to: "welcome#index"

  # get '/merchants/:id/dashboard', to: "dashboard#index"
  # get '/merchants/:id/items', to: "merchant_items#index"
  resources :merchants, only:[:show] do
    resources :items, only:[:index, :new, :create] 
    resources :dashboard, only:[:index]
  end

  get '/merchants/:id/invoices/:id', to: "merchant_invoices#show"

  # get '/merchants/:id/items/new', to: "merchant_items#new"
  # post '/merchants/:id/items', to: "merchant_items#create"
  get '/admin/merchants/:id/dashboard', to: "admin/dashboard#index"
  get '/merchants/:id/invoices', to: 'merchant_invoices#index'
  get '/merchants/:merchant_id/invoices/:id', to: 'merchant_invoices#show'
end

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # get '/', to: 'merchants#welcome'
  # get "/merchants/:id/dashboard", to: 'merchants#show'
  # get "/merchants/:id/items", to: 'merchants#item_index'
  # get "/merchants/:merchant_id/items/:item_id/edit", to: 'merchants#item_edit'
  # patch "/merchants/:merchant_id/items/:item_id", to: 'merchants#item_update'
  # get "/merchants/:id/items/new", to: 'merchants#item_new'
  # post "/merchants/:id/items", to: 'merchants#item_create'
  # get "/merchants/:merchant_id/items/:item_id", to: 'merchants#item_show'

  root 'merchants#welcome'

  resources :merchants, only: [:index, :show] do
    resources :items, shallow: true
  end       #nested  :index,:new,:create


###### Merchant Invoices routes below ######




########## Admin routes below ##############

  resources :admin, only: [:index]
  namespace :admin do
    resources :invoices, :merchants, only: [:index, :show]
  end
end

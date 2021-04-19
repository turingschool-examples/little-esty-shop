Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get '/', to: 'merchants#welcome'
  get "/merchants", to: 'merchants#index'

  get "/merchants/:id/dashboard", to: 'merchants#show'
  get "/merchants/:id/items", to: 'merchants#item_index'
  get "/merchants/:id/invoices", to: 'merchants#invoice_index'

  get "/merchants/:merchant_id/items/:item_id", to: 'merchants#item_show'
  get "/merchants/:merchant_id/invoices/:invoice_id", to: 'merchants#invoice_show'

########## Admin routes below ############

  resources :admin, only: [:index]
  namespace :admin do
    # resources :invoices, :merchants, only: [:index, :show, :edit, :update, :new]
    resources :invoices, :merchants, except: [:destroy]
  end
end

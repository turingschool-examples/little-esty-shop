Rails.application.routes.draw do
  get '/', to: 'application#welcome'

  resources :admin, only:[:index]
  resources :merchants, only:[:show] do
    resources :dashboard, only:[:index]
  # resources :invoices, only:[:index, :show]
  end

  get '/merchants/:id/items', to: 'merchants#show'
  get '/merchants/:id/invoices', to: 'merchants#show'
  get '/merchants/:id/invoices/:id', to: 'merchant_invoices#show'
  get 'merchants/:id/items/:id', to: 'merchant_items#show'
  
end

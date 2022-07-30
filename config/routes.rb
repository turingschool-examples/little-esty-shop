Rails.application.routes.draw do
get '/', to: 'application#welcome'

resources :merchants, only:[:show] do
  # resources :invoices, only:[:index, :show]
  resources :dashboard, only:[:index]
  end

get '/merchants/:id/items', to: 'merchants#show'
get '/merchants/:id/invoices', to: 'merchants#show'
get '/merchants/:id/invoices/:id', to: 'merchant_invoices#show'
get 'merchants/:id/items/:id', to: 'merchant_items#show'
end

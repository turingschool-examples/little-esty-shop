Rails.application.routes.draw do
resources :merchants, only:[:show] do
  # resources :invoices, only:[:index, :show]
  resources :dashboard, only:[:index]
  end

get '/', to: 'application#welcome'

get '/merchants/:id/items', to: 'merchants#show'
get '/merchants/:id/invoices/:id', to: 'invoices#show'
get '/merchants/:id/invoices', to: 'merchants#show'
end

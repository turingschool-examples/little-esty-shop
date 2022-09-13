Rails.application.routes.draw do

  resources :merchants, except: [:show] do 
    resources :invoices
    resources :items, only: [:index]
  end

  get '/merchants/:merchant_id/dashboard', to: 'merchants#show'
end

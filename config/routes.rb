Rails.application.routes.draw do
  
  # resources :merchants, only: [:show]
  get '/merchants/:merchant_id/dashboard', to: 'merchants#show'
end

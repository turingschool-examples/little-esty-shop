Rails.application.routes.draw do
  # merchants
  get '/merchants/:merchant_id/dashboard', to: 'merchants#show'

  # resources :merchants, only: [] do
  #   resources :dashboard, only: [:show], controller: 'merchants'
  # end
end

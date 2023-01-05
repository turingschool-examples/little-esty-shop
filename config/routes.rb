Rails.application.routes.draw do
  
  resources :merchants, only: [] do
    resources :items, only: [:index]
    resources :invoices, only: [:index]
  end
  
  resources :admin, only: [:index]

  namespace :admin do
    resources :merchants, only: [:index]
    resources :invoices, only: [:index, :show]
  end
  
  get '/merchants/:merchant_id/dashboard', to: 'merchants#show'
end

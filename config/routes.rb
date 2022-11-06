Rails.application.routes.draw do
  get '/admin', to: 'admin#index'
  get '/merchants/:merchant_id/dashboard', to: 'merchants#show'

  namespace :admin do
    resources :invoices, only: [:index, :show]
  end

  resources :merchants, only: [] do
    resources :items, only: [:index]
    resources :invoices, only: [:index]
  end
end

Rails.application.routes.draw do
  get '/merchants/:merchant_id/dashboard', to: 'merchants#show'

  resources :merchants, except: [:show] do
    resources :items, only: [:index, :show, :edit, :update]
    resources :invoices, only: [:index, :show]
  end

  namespace :admin do
    resources :merchants
  end
end

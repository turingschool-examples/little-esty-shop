Rails.application.routes.draw do
  get '/merchants/:merchant_id/dashboard', to: 'merchants#show'

  resources :merchants, except: [:show] do
    resources :items, only: [:index, :show, :edit, :update, :new, :create]
    resources :invoices, only: [:index, :show, :update]
  end

  resources :admin, only: [:index]

  namespace :admin do
    resources :merchants, only: [:index, :show, :update, :edit]
    resources :invoices, only: [:index, :show, :update]
  end
end

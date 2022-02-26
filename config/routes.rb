  Rails.application.routes.draw do


  get '/merchants', to: 'merchants#index'
    resources :merchants, only: [:show, :index, :update, :post], module: :merchant do
      resources :invoices
      resources :dashboard
      resources :items
    end
    namespace :admin, module: :admin do
      resources :dashboard
      resources :merchants
      resources :items
      resources :invoices
    end
end

  Rails.application.routes.draw do

  get '/merchants', to: 'merchants#index'
    resources :merchants, only: [:show, :index, :update, :post], module: :merchant do
      resources :invoices only: [:index, :show, :update]
      resources :dashboard only: [:index]
      resources :items [:index, :show, :edit, :update, :new, :create]
    end
    namespace :admin, only: [:index, :show, :edit, :update, :new, :create], module: :admin do
      resources :dashboard [:index]
      resources :merchants [:index, :show, :edit, :update, :new, :create]
      resources :invoices [:index, :show, :update]
    end
end

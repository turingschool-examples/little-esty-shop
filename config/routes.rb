  Rails.application.routes.draw do

  get '/merchants', to: 'merchants#index'
    resources :merchants, only: [:show, :index, :update, :post], module: :merchant do
      resources :invoices
      resources :items
    end
end

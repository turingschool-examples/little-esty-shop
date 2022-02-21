  Rails.application.routes.draw do

  get '/merchants', to: 'merchants#index'
    resources :merchants, only: [:show, :index], module: :merchant do
      resources :invoices
      resources :items
    end

end

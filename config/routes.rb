  Rails.application.routes.draw do

    resources :merchants, only: [:show, :index], module: :merchant do
      resources :invoices
    end

  # get '/merchants/:merchant_id/items', to: 'merchant_items#index'
  # get '/merchants/:merchant_id/items/:item_id', to: 'merchant_items#show'
  # get '/merchants/:merchant_id/items/:item_id/edit', to: 'merchant_items#edit'
  # patch '/merchants/:merchant_id/items/:item_id', to: 'merchant_items#update'

end

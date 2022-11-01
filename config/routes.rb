Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # get '/merchants/:merchant_id/items/:item_id', to: 'items#show'
  # get 'merchants/:id/items', to: 'merchant_items#index'

  resources :merchants, except: [:update] do
    resources :items, except: [:update]
  end

  #The 'as:' should allow these routes to be called the same way as the resource versions
  #These handrolled routes should work exactly the same as the resources:
  patch '/merchants/:id', to: 'merchants#update', as: 'merchant'
  patch '/merchants/:merchant_id/items/:id', to: 'items#update', as: 'merchant_item'
end


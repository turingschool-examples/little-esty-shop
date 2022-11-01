Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # get '/merchants/:merchant_id/items/:item_id', to: 'items#show'
  # get 'merchants/:id/items', to: 'merchant_items#index'

  resources :merchants, except: [:update] do
    resources :items, except: [:update]
    get 'merchants/:id/dashboard', to: 'merchants#show'
end

  #These handrolled routes must be accessed by their full URI, but otherwise work the same as their resource versions
  patch '/merchants/:id', to: 'merchants#update'
  patch '/merchants/:merchant_id/items/:id', to: 'items#update'

  
  get 'merchants/:id/dashboard', to: 'merchants#show'
end


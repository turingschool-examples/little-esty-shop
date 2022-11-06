Rails.application.routes.draw do

  # get '/merchants/:merchant_id/items/:item_id', to: 'items#show'
  # get 'merchants/:id/items', to: 'merchant_items#index'
  get 'merchants/:id/dashboard', to: 'merchants#show'

  resources :merchants, except: [:update] do
    resources :items, except: [:update]
  end

  patch '/merchants/:id', to: 'merchants#update'
  patch '/merchants/:merchant_id/items/:id', to: 'items#update'
  
  get 'merchants/:id/dashboard', to: 'merchants#show'

  namespace :admin do
    resources :merchants, except: [:update]
  end
  patch '/admin/merchants/:id', to: 'admin/merchants#update'
end

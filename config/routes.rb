Rails.application.routes.draw do
  resources :merchants, only: [:index] do
    resources :items, except: [:update]
  end

  patch '/merchants/:merchant_id/items', to: 'items#status_update'

  patch '/merchants/:merchant_id/items/:id', to: 'items#update'

  resources :admin, only: [:index]
end

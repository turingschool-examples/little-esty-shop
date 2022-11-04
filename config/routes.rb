Rails.application.routes.draw do
  resources :merchants, only: [:index] do
    resources :dashboard, only: [:index]
    resources :invoices, only: [:index]
    resources :items, except: [:update]
  end

  patch '/merchants/:merchant_id/items', to: 'items#update'
  patch '/merchants/:merchant_id/items/:id', to: 'items#update'

  resources :admin, only: [:index]

  namespace :admin do
    resources :merchants, :invoices

  end
  

end

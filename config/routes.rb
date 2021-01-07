Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get 'merchant/:merchant_id/items', to: 'merchant_items#index'
  get '/merchant/:merchant_id/items/:item_id', to: 'merchant_items#show'

  resources :merchants, only: [:index, :show] do
    resources :items, only: [:index]
    resources :invoices, only: [:index]
    resources :dashboard, only: [:index], path: '/dashboard'
  end

  resources :items

  resources :invoices
end

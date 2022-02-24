Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get '/merchants/:id/dashboard', to: 'merchants#show'

  resources :merchants, only:[] do
    resources :invoices, only: [:index, :show, :update]
    resources :merchant_items, only: [:index, :new, :show, :create, :edit, :update]
  end

  namespace :admin  do
    resources :merchants, only: [:index, :show, :edit, :update, :new, :create]
    resources :invoices, only: [:index, :show]
  end
end

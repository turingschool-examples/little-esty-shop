Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :admin, only: [:index]

  namespace :admin do
    resources :merchants, only: [:index]
    resources :invoices, only: [:index]
  end

 get '/merchants/:id/dashboard', to: 'merchants#show'
 get '/merchants/:id/items', to: 'merchants/items#index'
 get '/merchants/:id/invoices', to: 'merchants/invoices#index'

end
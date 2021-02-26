Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  #merchants
  resources :merchants, only: [:show] do
    resources :items, only: [:index]
    resources :invoices, only:[:index]
    get '/invoices/:id', to: 'merchants/invoices#show'
    get '/dashboard', to: 'merchants/dashboard#index'
  end
end

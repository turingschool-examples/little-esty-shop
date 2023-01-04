Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  #merchants
  # get '/merchants/:id/dashboard', to: 'merchants#show'
  resources :merchants, only: [:show] do 
    resources :dashboard, controller: "merchants"
    resources :items
    resources :invoices
  end
end

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  #merchants
  get '/merchants/:id/dashboard', to: 'merchants#show'
  # resources :merchants, only: [:show] do 
  #   resources :dashboard, controller: "merchants"
  #   resources :items
  #   resources :invoices
  # end

  resources :merchants do
    resources :items, only: [:index]
    resources :invoices, only: [:index, :show]
  end
end
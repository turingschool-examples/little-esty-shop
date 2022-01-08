Rails.application.routes.draw do

  namespace :admin do 
    resources :dashboard, only: [:index]
    resources :merchants, only: [:index, :show] 
    resources :invoices, only: [:index, :show]
  end 

  resources :merchants do 
    resources :items, only: [:index, :show]
    resources :invoices, only: [:index, :show]
    resources :dashboard, only: [:index]
  end
end

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  

  resources :merchants, only: [:show] do
    resources :items, controller: 'items'
    resources :items, controller: :merchant_items
    resources :invoices, controller: 'invoices'
    resources :dashboard, only: [:index]
  end
  
  




  namespace :admin do 
    resources :merchants, :invoices, :transactions
  end  

  resources :admin 

end

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :merchants do 
    resources :items 
    #creates routes for merchants and merchant_items 
    resources :invoices, only: [:show]
  end

  #creates routes for merchants and merchant_items 
  get 'merchants/:id/dashboard', to: 'merchant_dashboards#show'
end

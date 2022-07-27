Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :merchants, only: [:index]  do 
    resources :items, only: [:index], :controller => 'merchant_items'
    resources :invoices, only: [:index], :controller => 'merchant_invoices' 
  end

  get "/merchants/:id/dashboard", to: "merchants#dashboard"
end

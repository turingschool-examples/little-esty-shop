Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :admin, only: [:index]



  get '/merchants/:merchant_id/dashboard', to: 'merchant_dashboards#show', as: "merchants_merchantid_dashboard"
  
  #following are placeholders - delete when merging 
  # get '/merchants/:merchant_id/items', to: 'merchant_items#index'
  # get '/merchants/:merchant_id/invoices', to: 'merchant_invoices#index'

  resources :merchants, only: :show do
    resources :items, only: :index
    resources :invoices, only: :index
  end

end

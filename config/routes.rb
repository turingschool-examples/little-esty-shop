Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :admin, only: [:index]



  get '/merchants/:merchant_id/dashboard', to: 'merchant_dashboards#show', as: "merchants_merchantid_dashboard"
end

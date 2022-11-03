Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :admin do 
    resources :merchants, only: [:index, :show] 
  end
  get "/admin", to: "admin#index"
  # merchants
  get '/merchants/:merchant_id/dashboard', to: 'merchants#show'

  resources :merchants, only: [] do
    resources :items, only: [:index]
    resources :invoices, only: [:index]
  end
end

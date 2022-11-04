Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :admin do 
    resources :merchants #, only: [:index, :show, :edit, :patch] 
  end

   get "/admin", to: "admin#index"
  # get "/admin/merchants", to: "admin/merchants#show"
  # get "/admin/merchants/:id", to: "admin/merchants#index"
  # merchants
  get '/merchants/:merchant_id/dashboard', to: 'merchants#show'

  resources :merchants, only: [] do
    resources :items, only: [:index]
    resources :invoices, only: [:index]
  end
end

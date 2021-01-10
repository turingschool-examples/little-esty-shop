Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # get "/admin", to: "admin/dashboard#index"
  # get "/admin/merchants", to: "admin/merchants#index"
  
  namespace :admin do
    root :to => 'dashboard#index'
    resources :merchants, only: [:index, :show]
    resources :invoices, only: [:index, :show]
  end
  get '/merchants/:id/dashboard', to: 'merchants#dashboard'
end

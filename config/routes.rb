  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

Rails.application.routes.draw do
  resources :admin, only: [:index] do
    resources :merchants, only: [:index]
    resources :invoices, only: [:index]
  end

  namespace :admin do
    resources :merchants, only: [:index]
    resources :invoices, only: [:index, :show]
  end

  # get("/merchants/:id/dashboard",   to: "merchants_dashboard#index")
  get "/merchants/:id/dashboard",   to: "merchants#show"
  get "/merchants/:id/items", to: "items#index"
  get "/merchants/:id/invoices", to: "invoices#index"

end

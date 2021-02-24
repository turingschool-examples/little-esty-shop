Rails.application.routes.draw do

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :merchants do
    get "/dashboard", to: "merchants#dashboard"
    scope module: :merchant do
      resources :items
      resources :invoices
    end
  end
end

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get "/merchants/:id/dashboard", to: "merchants#show"
  # get "/merchants/:id/items", to: "items#show"
  resources :merchants do
    resources :items
    resources :invoices
  end
end

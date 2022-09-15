  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
Rails.application.routes.draw do
  get "/merchants/:id/dashboard",   to: "merchants#show"
  get "/merchants/:id/items", to: "items#index"
  get "/merchants/:id/invoices", to: "invoices#index"
end

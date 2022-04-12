Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get "/merchants/:id/items", to: "merchant_items#index"
  get "/merchants/:id/items/:id", to: "merchant_items#show"
  get "/merchants/:id/items/:id/edit", to: "merchant_items#edit"
  patch "/merchants/:id/items/:id", to: "merchant_items#update"

end

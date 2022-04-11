Rails.application.routes.draw do
  resources :merchants
  get "/merchants/:id/items", to: "merchant_items#index"
end

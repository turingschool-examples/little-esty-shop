Rails.application.routes.draw do
 get "/merchants/:id/items", to: "merchant_items#index"
 get "/merchants/:merchant_id/items/:item_id", to: "merchant_items#show"
end

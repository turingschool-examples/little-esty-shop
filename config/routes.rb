Rails.application.routes.draw do
 get "/merchants/:id/items", to: "merchant_items#index"
 # get '/professors', to: 'professors#index'
end

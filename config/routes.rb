Rails.application.routes.draw do
    get "/merchants/:id/dashboard", to: 'merchants#show'

    get "/merchants/:id/items" , to: 'merchant_items#index'
end

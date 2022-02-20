Rails.application.routes.draw do
    get "/merchants/:id/dashboard", to: 'merchant_dashboards#index'

    get "/merchants/:id/items" , to: 'merchant_items#index'
end

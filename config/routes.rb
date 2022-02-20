Rails.application.routes.draw do
    get "/merchant/:id/dashboard", to: 'merchant_dashboards#index'

    get "/merchants/:id/items" , to: 'merchant_items#index'
end

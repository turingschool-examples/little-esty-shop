Rails.application.routes.draw do
    get "/merchant/:id/dashboard", to: 'merchant_dashboards#index'

    get "/merchants/:id/items" , to: 'merchant_items#index'
    get "/merchants/:id/items/:item_id", to: 'merchant_items#show'
    get "/merchants/:id/items/:item_id/edit", to: 'merchant_items#edit'

    post '/merchants/:id/items' , to: 'merchant_items#change_status'
    patch "/merchants/:id/items/:item_id", to: 'merchant_items#update'

end

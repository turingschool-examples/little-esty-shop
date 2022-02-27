Rails.application.routes.draw do
    get '/', to: 'welcome#index'

    get "/merchant/:id/dashboard", to: 'merchant_dashboards#index'

    get "/merchants/:id/invoices/:invoice_id", to: 'merchant_invoices#show'
    patch "/merchants/:id/invoices/:invoice_id", to: 'merchant_invoices#update'

    get "/merchants/:id/items" , to: 'merchant_items#index'
    get "/merchants/:id/items/new", to: 'merchant_items#new'
    get "/merchants/:id/items/:item_id", to: 'merchant_items#show'
    get "/merchants/:id/items/:item_id/edit", to: 'merchant_items#edit'

    post '/merchants/:id/items' , to: 'merchant_items#create'
    patch '/merchants/:id/items' , to: 'merchant_items#change_status'
    patch "/merchants/:id/items/:item_id", to: 'merchant_items#update'

    get '/merchants/:merchant_id/invoices', to: 'merchant_invoices#index'

    namespace :admin do
        resources :merchants
    end
end

# Rails.application.routes.draw do
#     resources :merchant do
#         resources :dashboard, only: [:show] do
#         resources :items
#         end
#     end
# end

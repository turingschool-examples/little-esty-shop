Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/merchants/:merchant_id/items', to: 'merchant_items#index'
  get '/merchants/:merchant_id/items/:item_id', to: 'merchant_items#show'
  get '/merchants/:merchant_id/items/:item_id/edit', to: 'merchant_items#edit'
  patch  '/merchants/:merchant_id/items/:item_id', to: 'merchant_items#update'
  
  # get '/items/:item_id/edit', to: 'items#edit'
  # patch '/items/:item_id', to: 'items#update'
end

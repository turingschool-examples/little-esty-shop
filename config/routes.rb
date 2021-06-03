Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/merchants/:merchant_id/items', to: 'merchant_items#index'
  get '/merchants/:merchant_id/items', to: 'merchant_items#index'
  get '/merchants/:merchant_id/items', to: 'merchant_items#index'
  get '/merchants/:merchant_id/items/new', to: 'merchant_items#new'
  post '/merchants/:merchant_id/items', to: 'merchant_items#create'
end

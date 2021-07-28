Rails.application.routes.draw do
  resources :customers
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/merchants/:id/dashboard', to: 'merchants#dashboard'
  get '/merchants/:id/items', to: 'merchant_items#index'
end

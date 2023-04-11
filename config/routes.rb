Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :admin, only: [:index]
  resources :merchants, only: [] do
    resources :items, only: [:index], controller: 'merchants/items'
  end
end

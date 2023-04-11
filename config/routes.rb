Rails.application.routes.draw do

  resources :merchants, only: [] do
    resources :items, only: [:index], controller: 'merchants/items'
  end
end

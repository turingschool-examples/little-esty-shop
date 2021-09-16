Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :merchants, only: [] do
    # resources :items, only: []
    get "/items", to: "merchant_items#index"
  end
end

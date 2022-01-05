Rails.application.routes.draw do

  # get "merchants/:id/items", to "merchant_items#index"
  resources :merchants do
    resources :items, only: [:index, :show], controller: :merchant_items
  end


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

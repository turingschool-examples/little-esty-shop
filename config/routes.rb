Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'welcome#index'

  resources :merchants, only: :index do
    resources :items, only: [:index], controller: :merchant_items
  end
end

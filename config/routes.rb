Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :merchants, only: [] do
    get '/items', to: 'merchant_items#index'
    resources :items, only: [:show, :edit]
  end

  namespace :admin, only: [:index, :show] do
    resources :merchants
  end
end

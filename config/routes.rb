Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get '/merchants', to: 'merchants#index'
  get '/merchants/:id/dashboard', to: 'merchants#show'

  # get '/merchants/:id/items', to: 'merchants_items#index'
  resources :merchants, only: [] do
    scope module: "merchants" do
      resources :items, only: [:index, :show, :edit, :update]
    end
  end

  get '/admin', to: 'admin/dashboard#index'

  namespace :admin do
    resources :merchants, only: [:index, :show]
  end
end

Rails.application.routes.draw do

  # get "merchants/:id/items", to "merchant_items#index"
  resources :merchants do
    resources :items, only: [:index, :show, :edit, :update], controller: :merchant_items
  end


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'welcome#index'
  get '/welcome', to: 'welcome#index'
  get '/merchants/:id/dashboard', to: 'merchants#show'
  get '/admin/dashboard', to: 'admin#index'
  # get "/merchants/:id/items", to: "items#show"
  resources :merchants, except: [:show] do
    resources :items
    resources :invoices
  end
end

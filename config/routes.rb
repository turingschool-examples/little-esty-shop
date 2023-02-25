Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :admin, only: :index
  patch '/admin/merchants/:id', to: "admin/merchants#update"

  namespace :admin do
    resources :merchants, only: [:index, :show, :edit, :update]
		resources :invoices, only: [:index, :show]
  end
  get '/merchants/:id/dashboard', to: "merchants#show"
  get '/merchants/:id/items', to: "merchant_items#index"
  get '/merchants/:id/items/:item_id', to: "merchant_items#show"

  get '/merchants/:id//items/:item_id/edit', to: "merchant_items#edit", as: "edit_merchant_item"
  patch '/merchants/:id/items/:item_id', to: "merchant_items#update"


  # get '/merchants/:merchant_id/invoices', to: "invoices#index"

  resources :admin, only: :index

  resources :merchants, only: [:show] do
    resources :invoices, only: [:index, :show]
  end

end

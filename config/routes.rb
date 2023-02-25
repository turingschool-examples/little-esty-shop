Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :admin, only: :index
  patch '/admin/merchants/:id', to: "admin/merchants#update"

  namespace :admin do
    resources :merchants, only: [:index, :show, :edit, :update]
		resources :invoices, only: [:index, :show]
  end

  get '/merchants/:id/dashboard', to: "merchants#show"
	patch '/merchants/:merchant_id/items/:id', to: "merchant_items#update"


  get '/merchants/:id/invoices', to: "invoices#index"

  resources :admin, only: :index

	resources :merchants, only: :show do
		resources :items, only: [:index, :show, :edit], controller: 'merchant_items'
	end

end
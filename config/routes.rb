Rails.application.routes.draw do

# get '/merchant', to: 'merchants#dashboard'
  resources:merchants, module: :merchant do
    resources:dashboard, only: [:index]
    resources:items
    resources:invoices
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
	# get "/admin", to:"admins#dashboard"
	get "/admin", to:"admin/dashboard#index"
	namespace :admin do
		resources :merchants, only: [:index, :show, :edit, :new, :create, :update, :destroy]
		resources :invoices, only: [:index, :show, :destroy]
	end
end

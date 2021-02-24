Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
	get "/admin", to:"admins#dashboard" 
	namespace :admin do
		resources :merchants, only: [:index, :show, :destroy]
		resources :invoices, only: [:index, :show, :destroy]
	end

end

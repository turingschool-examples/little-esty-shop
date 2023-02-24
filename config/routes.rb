Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :admin, only: :index
  patch '/admin/merchants/:id', to: "admin/merchants#update"

  namespace :admin do
    resources :merchants, only: [:index, :show, :edit]
		resources :invoices, only: [:index]
  end

end

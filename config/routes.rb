Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :admin, controller: 'admin/dashboard', only: [:index]
  namespace :admin do
    resources :merchants, only: [:index, :show, :update, :create]
    resources :invoices, only: [:index, :show]
  end
end

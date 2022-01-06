Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :admin, controller: 'admin/dashboard', only: [:index]
  namespace :admin do
    resources :merchants, only: [:index, :show, :update, :create, :edit, :new]
    resources :invoices, only: [:index, :show]
  end

  get '/admin/merchants/new', to: 'admin/merchants#new'
  patch '/admin/merchants', to: 'admin/merchants#update'
end

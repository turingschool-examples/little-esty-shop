Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :customers
  resources :merchants, module: :merchant do
    resources :items
    resources :invoices
    get '/dashboard', to: 'merchants#dashboard'
  end

  resources :items, only: [:edit, :update, :new, :create]

  patch '/admin/merchants/update/:id', to: 'admin/merchants#update_status', as: 'update_status'

  namespace :admin do #resources :admin, module: :admin do (namespace gives: scope, module and rake routes)
    resources only: [:index]
    resources :merchants
    resources :invoices
  end
end

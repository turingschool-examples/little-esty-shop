Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :merchant do
    resources :dashboard, only: [:index]
    resources :items
    resources :invoices
  end

  resources :admin, only: [:index]

  namespace :admin do
    resources :merchants, only: [:index, :show, :edit, :update, :new, :create ]
    resources :invoices
  end
end

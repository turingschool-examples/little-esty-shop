Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :merchants, only: [:index, :show] do
    resources :items, only: [:index]
    resources :invoices, only: [:index]
    resources :dashboard, only: [:index], path: '/dashboard'
  end

  resources :items

  resources :invoices
end

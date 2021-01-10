Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :merchant, only: [:show] do
    resources :dashboard, only: [:index]
    resources :items, only: [:index]
    resources :invoices, only: [:index]
  end

  namespace :admin do 
    resources :dashboard, only: [:index]
    resources :merchants, only: [:index, :show, :edit, :update]
    resources :merchant_status, only: [:update]
    resources :invoices, only: [:index, :show]
  end
end

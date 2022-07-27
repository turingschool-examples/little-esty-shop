Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :merchants, only: [:index] do
    resources :dashboard, only: [:index]
    resources :items
    resources :items, only: [:index]
    resources :invoices, only: [:index]
  end
end

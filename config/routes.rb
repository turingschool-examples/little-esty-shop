Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :merchants do
    get 'dashboard', on: :member
    resources :items, only: [:index]
    resources :invoices, only: [:index, :show]
  end

  namespace :admin do
    root to: 'dashboard#index', as: 'dashboard'
    resources :merchants, only: [:index, :show]
    resources :invoices, only: [:index, :show]
  end

end

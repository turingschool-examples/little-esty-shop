Rails.application.routes.draw do
  resources :merchants, only: [:show] do
    resources :dashboard, only: [:index]
    resources :items
    resources :invoices
  end

  resources :admin, only: [:index]

  namespace :admin do
    resources :invoices, only: [:index, :show]
    resources :merchants, only: [:index]
  end
end

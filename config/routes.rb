Rails.application.routes.draw do
  resources :merchants do
    resources :dashboards, only: [:index, :create]
    resources :items, only: [:index]
    resources :invoices, only: [:index]
  end

  namespace :admin do
    resources :dashboard, only: [:index]
    resources :invoices, only: [:index]
    resources :merchants, only: [:index]
  end
end

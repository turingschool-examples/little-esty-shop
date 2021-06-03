Rails.application.routes.draw do

  resources :merchants, only: :index do
    member do
      get :dashboard
    end
    resources :items, only: [:index, :show, :create, :update]
    resources :invoices, only: [:index, :show]
  end

  ########## Admin routes below ##############

  resources :admin, only: [:index], as: "admin_dashboard"
  namespace :admin do
    resources :merchants, only: [:index]
    resources :invoices, only: [:index]
  end
end

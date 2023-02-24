Rails.application.routes.draw do
  resources :admin, only: :index, controller: "admins"

  namespace :admin do
    resources :merchants, only: :index
  end

  namespace :admin do
    resources :invoices, only: [:index, :show]
  end
end

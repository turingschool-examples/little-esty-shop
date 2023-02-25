Rails.application.routes.draw do
  resources :admin, only: :index

  namespace :admin do
    resources :invoices, only: [:index, :show]
    resources :merchants, only: [:index, :show, :edit, :update]
  end
end

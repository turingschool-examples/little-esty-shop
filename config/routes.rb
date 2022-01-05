Rails.application.routes.draw do
  resources :merchants, only:[:show] do
    resources :items, only:[:index, :show]
    resources :invoices, only:[:index]
    resources :dashboard, only:[:index]
  end

  resources :admin, controller: 'admin/dashboard', only: [:index]
  namespace :admin do
    resources :merchants, only: [:index, :show, :update, :create]
    resources :invoices, only: [:index, :show]
  end
end

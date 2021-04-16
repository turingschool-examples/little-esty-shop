Rails.application.routes.draw do
  namespace :admin do
    resources :merchant
    get '', to: 'dashboard#index', as: '/'
  end

  resources :merchant do
    resources :dashboard, only: [:index]
    resources :invoices, only: [:index, :show]
    resources :items, only: [:index, :show, :edit, :update, :new, :create]
  end
end

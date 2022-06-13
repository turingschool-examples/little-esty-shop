Rails.application.routes.draw do
  get '/', to: 'application#welcome'
  resources :merchants, only: %i[show index update post], module: :merchant do
    resources :invoices, only: %i[index show update]
    resources :dashboard, only: [:index]
    resources :items, only: %i[index show edit update new create]
    resources :bulk_discounts
  end

  namespace :admin, only: %i[index show edit update new create], module: :admin do
    resources :dashboard, only: [:index]
    resources :merchants, only: %i[index show edit update new create]
    resources :invoices, only: %i[index show update]
  end
end

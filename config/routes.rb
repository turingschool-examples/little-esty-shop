Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get '/', to: 'application#welcome'

  resources :merchant, only: [:show]
  resources :admin, only: [:show]

  namespace :merchants do
    resources :items
    resources :invoices
  end

  namespace :admin do
    resources :merchants
    resources :invoices
  end
end

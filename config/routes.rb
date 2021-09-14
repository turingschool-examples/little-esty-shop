Rails.application.routes.draw do
  get 'admin/show'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get '/', to: 'application#welcome'

  resources :merchant, only: [:show]
  resources :admin

  namespace :merchants do
    resources :items
    resources :invoices
  end

  namespace :admin do
    resources :merchants
    resources :invoices
  end
end

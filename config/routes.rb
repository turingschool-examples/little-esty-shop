Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'welcome#index'

  # get '/admins', to: 'admins#index'

  namespace :admin do
    resources :dashboard, only: [:index]
    resources :merchants
    resources :invoices, only: [:show]
    # resources :admins
    resources :customers
  end

  resources :merchants do
    resources :dashboard, only: [:index]
    resources :items
    resources :invoices
  end
end

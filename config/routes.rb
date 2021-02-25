Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'welcome#index'

  # get '/admins', to: 'admins#index'

  namespace :admin do
    resources :dashboard, only: [:index]
    # resources :admins
    resources :merchants
    resources :customers
  end
end

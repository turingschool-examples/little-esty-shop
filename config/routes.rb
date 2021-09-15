Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # get '/admin', to: 'dashboard#index'


  namespace :admin do
    resources :dashboard, only: [:index]
    resources :merchants
    resources :invoices
  end
end

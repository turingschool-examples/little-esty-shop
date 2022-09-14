Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get '/merchants/:id/dashboard', to: 'merchants#dashboard'

  resources :merchants do
    resources :items
    resources :invoices
  end

  namespace :admin do
    resources :items
    resources :invoices
    resources :merchants
  end
end

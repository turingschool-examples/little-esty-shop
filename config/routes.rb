Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :merchants do
    resources :dashboard, only: :index
    resources :items, only: [:index, :show, :edit, :update]
    resources :invoices, only: :index
  end

  get '/admin', to: 'admin#index'

  namespace :admin do
    resources :merchants
    resources :invoices
  end
end

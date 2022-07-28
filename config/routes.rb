Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'welcome#index'

  namespace :admin do 
    resources :merchants, only: [:index]
  end

  resources :merchants, only: [:index]  do
    resources :items, only: [:index, :show, :new, :create, :edit, :update], :controller => 'merchant_items'
    resources :invoices, only: [:index, :show, :update], :controller => 'merchant_invoices'
  end

  get "/merchants/:id/dashboard", to: "merchants#show"

end

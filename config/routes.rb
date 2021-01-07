Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
namespace :api do
  get "/github_api", to: "github_api#index", as: 'github_index'
end

  resources :merchants, only: [:index, :show]
  resources :items, only: [:index, :show]
  resources :customers, only: [:index, :show]
  resources :invoices, only: [:index, :show]
  resources :transactions, only: [:index, :show]
  
  namespace :admin do
    resources :merchants, only: [:index, :show]
    resources :items, only: [:index, :show]
    resources :customers, only: [:index, :show]
    resources :invoices, only: [:index, :show]
    resources :transactions, only: [:index, :show]
  end
end

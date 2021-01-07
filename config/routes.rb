Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
namespace :services do
  get "/repo_name", to: "github_api#get_data"
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

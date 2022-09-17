Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/', to: 'welcome#index'

  namespace :admin do
    get '/', to: 'dashboard#index'
    resources :merchants
    resources :invoices
  end

  resources :merchants, only: [:show] do
    get '/dashboard', to: 'merchants#show'
    resources :invoices, only: [:show]
    resources :items, only: [:index, :show, :edit, :update]
  end

end

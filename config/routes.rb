Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/', to: 'welcome#index'

  namespace :admin, only: [:index] do
    get '/', to: 'dashboard#index'
    resources :merchants, only: [:edit, :index, :new, :show, :create]
    patch '/merchants/:id', to: 'merchants#update'

    resources :invoices, only: [:index, :show]
    patch '/invoices/:id', to: 'invoices#update'
  end

  resources :merchants, only: [:show] do
    get '/dashboard', to: 'merchants#show'
    resources :invoices, only: [:index ,:show, :update]
    resources :items, only: [:new, :index, :show, :edit, :update, :create]
    patch '/items', to: 'items#update'
    resources :discounts 
    # only: [:new, :index, :show, :create, :destroy, :edit]
  end

end

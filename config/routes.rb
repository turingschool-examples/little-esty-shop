Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'application#welcome'

  resources :merchants, only: :index do
    get 'dashboard', action: :show, as: 'dashboard'

    resources :items, only: [:index, :show, :edit, :update], controller: 'merchant/items'
    patch '/items/:id/toggle_item', to: 'merchant/items#toggle_item', as: 'toggle_item'

    resources :invoices, only: [:index, :show], controller: 'merchant/invoices'
  end

  get '/admin', to: 'admin#index'

  resources :invoices, only: [:update]

  namespace :admin do
    resources :merchants, except: [:destroy, :create , :update]
    resources :invoices, only: [:index, :show, :update]
  end
end

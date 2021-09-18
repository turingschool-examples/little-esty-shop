Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :merchants, only: [] do
    get  '/dashboard', to: 'merchants#show'

    get  '/items',     to: 'merchant_items#index'
    post '/items',     to: 'merchant_items#create'
    resources :items, only: [:new, :show, :edit, :update]

    get  '/invoices',  to: 'merchant_invoices#index'
  end

  namespace :admin, only: [:index, :show, :edit, :update] do
    resources :merchants
  end
end

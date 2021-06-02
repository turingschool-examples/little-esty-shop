Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get '/merchants/:merchant_id/dashboard', to: 'merchants#show', as: 'merchant_dashboard'

  resources :merchants
    resources :items, only: [:index, :show]
    resources :invoices, only: [:index, :show]
  end
end

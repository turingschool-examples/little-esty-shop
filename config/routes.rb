Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :merchants, shallow: true do
    # get '/dashboard', to: 'dashboard#show', as: 'merchant_dashboard'
    resources :dashboard
  end
end

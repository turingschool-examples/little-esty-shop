Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # resources :merchants, only:[:show] do
    get '/merchants/:id/dashboard', to: 'dashboard#index'
end

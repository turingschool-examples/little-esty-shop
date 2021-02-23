Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  #merchants
  resources :merchants, only: [:show] do
        resources :dashboard, only: [:index]
  end
end

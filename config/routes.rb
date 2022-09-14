Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :merchants do
    resources :items, only: [:index]
  end

  namespace :admin do
    resources :merchants, only: [:index]
  end

  resources :items, only: [:show]
end

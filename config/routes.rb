Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :merchants do
    resources :items, only: %i[index show edit update]
  end

  namespace :admin do
    resources :merchants, only: %i[index show edit update]
  end
end

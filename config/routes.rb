Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get '/merchants/:id/dashboard', to: 'merchants#dashboard'


  resources :merchants do
    resources :items, only: [:index]
  end

  namespace :admin do
    resources :merchants, only: [:index, :show, :edit, :update, :new, :create]
  end

  resources :items, only: [:show]

end

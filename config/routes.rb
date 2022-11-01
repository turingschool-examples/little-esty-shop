Rails.application.routes.draw do

  resources :merchants, only: [:index] do
    resources :dashboard, only: [:index]
  end
end

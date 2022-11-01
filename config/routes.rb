Rails.application.routes.draw do
  resources :merchants, only: [:index] do
    resources :items, only: [:index, :show]
  end

  resources :admin, only: [:index]
end

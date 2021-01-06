Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :merchant, only: [:show] do
    resources :dashboard, only: [:index]
  end
end

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :merchants, only: [:show] do
    resources :dashboard, only: [:index]
    # get "/dashboard", controller: :merchants, action: :show, as: "dashboard"
  end
end

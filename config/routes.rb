Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :merchants, only: [:show] do
    resources :dashboard, only: [:index]
    resources :items, only: [:index, :show]
    resources :invoices, only: [:index, :show]
    # get "/dashboard", controller: :merchants, action: :show, as: "dashboard"
  end
end

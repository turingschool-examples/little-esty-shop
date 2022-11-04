Rails.application.routes.draw do

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :merchants, only: [:index] do
    resources :items, except: [:destroy]
    resources :invoices, only: [:index]
    resources :dashboard, only: [:index]
  end

  get "/admin", to: "admin#index"

  namespace(:admin) do
    resources(:merchants) do
    end
    resources :invoices, only: [:index, :show]
  end
end
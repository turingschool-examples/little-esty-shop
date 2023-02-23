Rails.application.routes.draw do
  resources :admin, only: :index, controller: "admins"

  namespace :admin do
    resources :merchants, only: :index
  end
end

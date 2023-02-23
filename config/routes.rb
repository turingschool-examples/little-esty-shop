Rails.application.routes.draw do
  resources :admin, only: :index, controller: "admins"
end

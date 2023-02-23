Rails.application.routes.draw do

  get 'dashboard/index'
  resources :merchant do
    resources :dashboard, only: [:index]
  end

end

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :admin, only: [:index]

  patch '/admin/merchants', to: 'admin/merchants#enable', as: 'enabled'

  namespace :admin do
    resources :merchants
  end
end

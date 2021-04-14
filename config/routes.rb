Rails.application.routes.draw do
  namespace :admin do
    resources :merchants
    get '', to: 'dashboard#index', as: '/'
  end

  resources :merchant do
    resources :dashboard
  end

end

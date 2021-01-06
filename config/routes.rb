Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :merchant do
    member do
      get 'dashboard'
    end
  end
end

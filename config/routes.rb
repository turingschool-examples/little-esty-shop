Rails.application.routes.draw do
resources :merchants, only:[:show] do
  resources :dashboard, only:[:index]
  resources :items, only:[:index]
  end
end

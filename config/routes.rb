Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'welcome#index'

  get '/admins', to: 'admins#index'
  # get '/admins', to: 'admins/merchants#index'
  # get '/admins', to: 'admins#index'
  resources :admins do
    resources :merchants
  end
end

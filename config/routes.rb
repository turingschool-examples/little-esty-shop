Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'merchant#index'
  get '/merchants/:id/dashboard', to: 'merchant#dashboard'
end

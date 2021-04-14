Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html













  get '/admin', to: 'application#admin'
  # namespace :admin do 
  # resources :admin, only: [:index, :home]
  # end
end

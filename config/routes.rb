Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get '/admin', to: 'admins#index' # handrolled this route for admin dashboard 
  namespace :admin do
    resources :invoices, only: [:index, :show, :update]
    resources :merchants, except: [:destroy]
  end

end

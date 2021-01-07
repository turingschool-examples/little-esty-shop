Rails.application.routes.draw do

  resources :admin, :only => [:index]

  namespace :admin do
    resources :merchants, :except => [:destroy]
    resources :invoices, :except => [:new, :create, :destroy]
  end

end
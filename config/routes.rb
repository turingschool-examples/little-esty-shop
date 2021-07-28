Rails.application.routes.draw do

  get '/', to: 'welcome#index'
  
  resources :merchants, only: [:show, :index] do
    resources :items, :invoices
  end

  namespace :admin do 
    resources :merchants, :invoices
  end 

end

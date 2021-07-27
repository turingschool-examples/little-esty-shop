Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/', to: 'welcome#index'
  
  resources :merchants, only: [:show, :index] do
    resources :items, :invoices
  end

  namespace :admin do 
    resources :merchants, :invoices
  end 

end

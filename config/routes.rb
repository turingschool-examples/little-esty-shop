Rails.application.routes.draw do
  get '/admin', to: 'admins#dashboard' 
  shallow do 
    namespace :admin do 
      resources :merchants, :invoices
    end
  end
end

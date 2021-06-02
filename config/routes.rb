Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :admin do
    get '/', to: 'dashboard#index'
    get '/merchants', to: 'merchant#index'
    get '/invoices', to: 'invoice#index'
  end
end

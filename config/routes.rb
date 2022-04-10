Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
get '/admin', to: 'admin#index'
namespace :admin do
  get '/merchants', to: 'merchants#index'
  get '/invoices', to: 'invoices#index'
end


end

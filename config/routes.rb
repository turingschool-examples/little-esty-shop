Rails.application.routes.draw do
  get '/admin', to: 'admin#index'
  get '/admin/merchants', to: 'admin#merchants'
end

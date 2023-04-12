Rails.application.routes.draw do
  get '/merchants/:id/dashboard', to: 'merchants#show', as: 'merchant_dashboard'

  get '/admin', to: 'admin#show', as: 'admin_dashboard'
end

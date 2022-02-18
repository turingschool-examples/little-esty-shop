Rails.application.routes.draw do
  get '/', to: 'welcome#index'
  get '/merchants/:id/dashboard', to: 'merchants#dashboard'
end

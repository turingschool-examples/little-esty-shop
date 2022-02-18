Rails.application.routes.draw do
  get '/', to: 'welcome#index'


  get '/admin/merchants', to: 'admin_merchants#index'

  get '/merchants/:id/dashboard', to: 'merchants#dashboard'
end

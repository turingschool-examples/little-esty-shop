Rails.application.routes.draw do
  get '/', to: 'welcome#index'

  scope :merchants, module: :merchants do
    get ':id/dashboard', to: 'dashboard#index'
    get ':id/items', to: 'items#index'
    get ':id/invoices', to: 'invoices#index'
  end

  scope :admin, module: :admin do
    get '/merchants', to: 'merchants#index'
    get '/merchants/new', to: 'merchants#new'
    post '/merchants/create', to: 'merchants#create'
  end
end

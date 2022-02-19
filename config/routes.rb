Rails.application.routes.draw do
  get '/', to: 'welcome#index'

  scope :merchants, module: :merchants do
    get ':id/dashboard', to: 'dashboard#index'
    get ':id/items', to: 'items#index'
  end

  scope :admin, module: :admin do
    get '/merchants', to: 'merchants#index'
  end
end

Rails.application.routes.draw do
  get '/', to: 'welcome#index'

  get '/merchants/:id/dashboard', to: 'merchants#dashboard'

  # scope :merchant, module: :item do
  #   get 'items', to: 'items#index'
  # end

  scope :admin, module: :admin do
    get '/merchants', to: 'merchants#index'
  end

end

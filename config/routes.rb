Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :merchants do
    get '/:id/items', to: 'items#index'
  end
end

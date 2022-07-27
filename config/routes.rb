Rails.application.routes.draw do
  get 'merchants/:id/items', to: 'items#index'
end

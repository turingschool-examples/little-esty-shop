Rails.application.routes.draw do
  get 'merchants/:id/items', to: 'items#index'
  get 'merchants/:id/items/:id', to: 'items#show'
end

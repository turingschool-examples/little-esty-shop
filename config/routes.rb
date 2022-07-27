Rails.application.routes.draw do
resources :merchants, only:[:show] do
  resources :dashboard, only:[:index]
  end

get '/', to: 'application#welcome'

get '/merchants/:id/items', to: 'merchants#show'
end

Rails.application.routes.draw do
get '/', to: 'application#welcome'

resources :merchants, only:[:show] do
  resources :dashboard, only:[:index]
  end

get '/merchants/:id/items', to: 'merchants#show'
end

Rails.application.routes.draw do
  resources :merchants do
    get 'dashboard', to:'merchant/dashboard#show', on: :member
  end
end

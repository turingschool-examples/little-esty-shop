Rails.application.routes.draw do
  resources :merchant do
    resources :dashboard, :items 
  end
end

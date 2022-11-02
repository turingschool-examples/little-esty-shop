Rails.application.routes.draw do

  resources :merchants, only: [:index] do 
    resources :items, only: [:index, :show, :edit, :update]
  end
  
  get "/admin", to: "admin#index"
  
  namespace(:admin) do
    resources(:merchants) do
    end
  end
end

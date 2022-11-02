Rails.application.routes.draw do

  resources :merchants, only: [:index] do 
    resources :items, only: [:index, :show, :edit, :update]
  end
  
  namespace(:admin) do
    resources(:merchants) do
    end
  end
end

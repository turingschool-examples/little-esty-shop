Rails.application.routes.draw do

#-------Merchant-------------------

#-------Admin----------------------
  namespace :admin do
    resources :merchants do
      member do
        post :update_status
      end
    end
  end
end

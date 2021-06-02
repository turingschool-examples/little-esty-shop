Rails.application.routes.draw do

#-------Merchant-------------------

#-------Admin----------------------
  namespace :admin do
    resources :merchants
  end
end

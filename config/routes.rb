Rails.application.routes.draw do
resources :merchants, only:[:show] do

end
end

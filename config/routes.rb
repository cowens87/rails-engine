Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
   namespace :api do
    namespace :v1 do
      resources :merchants, module: :merchants, only: [:index, :show] do 
        resources :items, controller: 'items', only: [:index]
      end
    end
  end
end

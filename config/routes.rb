Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
   namespace :api do
    namespace :v1 do

      resources :merchants, module: :merchants, only: [:index, :show] do 
        resources :items, controller: 'items', only: [:index]
        collection do
          get '/find', to: 'search#index'
        end
      end

      resources :items, module: :items, only: [:index, :show, :create, :update, :destroy] do 
        resources :merchants, only: [:index]
        collection do
          get '/find_all', to: 'search#index'
        end
      end

      resources :revenue, only: [:index]
      namespace :revenue do
        resources :merchants, only: [:index, :show]
      end
    end
  end
end

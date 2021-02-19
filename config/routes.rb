Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
   namespace :api do
    namespace :v1 do

      resources :merchants, module: :merchants, only: [:index, :show] do 
        resources :items, controller: 'items', only: [:index]
        collection do
          get '/find', to: 'search#find'
          get '/most_items', to: 'search#most_items'
        end
      end

      resources :items, module: :items, only: [:index, :show, :create, :update, :destroy] do 
        resources :merchant, only: [:index]
        collection do
          get '/find_all', to: 'search#find_all'
        end
      end

      resources :revenue, only: [:index]
      namespace :revenue do
        resources :merchants, only: [:index, :show]
        get '/unshipped', to: 'invoices#index'
      end
    end
  end
end

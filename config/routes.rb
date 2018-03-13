Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      namespace :merchants do
        get 'find', to: 'search#show'
        get 'find_all', to: 'search#index'
        get 'random', to: 'random#index'
      end
      resources :merchants, only: [:index, :show]

      namespace :transactions do
        get 'find', to: 'search#show'
        get 'find_all', to: 'search#index'
        get 'random', to: 'random#index'
      end
      resources :transactions, only: [:index, :show]

      namespace :customers do
        get 'random', to: 'random#index'
      end
      resources :customers, only: [:index, :show]
    end
  end
end

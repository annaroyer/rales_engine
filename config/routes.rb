Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      namespace :merchants do
        get 'find', to: 'search#show'
        get 'find_all', to: 'search#index'
        get 'random', to: 'random#index'
        get '/:id/items', to: 'items#index'
        get '/:id/invoices', to: 'invoices#index'
        get '/revenue', to: 'revenue#index'
        get '/most_revenue', to: 'most_revenue#index'
        get '/most_items', to: 'most_items#index'
        get '/:id/customers_with_pending_invoices', to: 'pending_invoices#index'
        get '/:id/favorite_customer', to: 'favorite_customer#index'
        get '/:id/revenue', to: 'revenue#show'
      end
      resources :merchants, only: [:index, :show]

      namespace :transactions do
        get 'find', to: 'search#show'
        get 'find_all', to: 'search#index'
        get 'random', to: 'random#index'
        get '/:id/invoice', to: 'invoice#index'
      end
      resources :transactions, only: [:index, :show]

      namespace :customers do
        get 'find', to: 'search#show'
        get 'find_all', to: 'search#index'
        get 'random', to: 'random#index'
        get '/:id/invoices', to: 'invoices#index'
        get ':id/transactions', to: 'transactions#index'
        get '/:id/favorite_merchant', to: 'merchants#show'
      end
      resources :customers, only: [:index, :show]

      namespace :invoices do
        get '/find', to: "search#show"
        get '/find_all', to: "search#index"
        get '/random', to: "random#show"
        get '/:id/transactions', to: 'transactions#show'
        get '/:id/invoice_items', to: 'invoice_items#show'
        get '/:id/items', to: 'items#show'
        get '/:id/customer', to: 'customer#show'
        get '/:id/merchant', to: 'merchant#show'
      end
      resources :invoices, only: [:index, :show]

      namespace :items do
        get '/find', to: "search#show"
        get '/find_all', to: "search#index"
        get '/random', to: "random#show"
        get '/most_revenue', to: 'most_revenue#index'
        get '/most_items', to: 'sales#index'
        get '/:id/invoice_items', to: 'invoice_items#show'
        get '/:id/merchant', to: 'merchants#show'
        get '/:id/best_day', to: 'sales#show'
      end
      resources :items, only: [:index, :show]

      namespace :invoice_items do
        get '/find', to: "search#show"
        get '/find_all', to: "search#index"
        get '/random', to: "random#show"
        get '/:id/invoice', to: 'invoices#show'
        get '/:id/item', to: 'items#show'
      end
      resources :invoice_items, only: [:index, :show]
    end
  end
end

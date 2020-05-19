Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :merchants, except: [:new, :edit] do
        get '/items', to: 'items_by_merchant#index'
      end
      resources :items, except: [:new, :edit] do
        get '/merchant', to: 'merchant_by_item#show'
      end
    end
  end
end

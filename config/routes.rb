Spree::Core::Engine.routes.draw do
  namespace :admin do
    resources :orders do
      collection do
        get 'fulfillment_list'
      end
      member do
        get 'ready'
      end
    end

  end

end

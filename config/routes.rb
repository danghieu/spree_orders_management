Spree::Core::Engine.routes.draw do
  namespace :admin do
    resources :time_frames
    resources :orders do
      collection do
        match 'fulfillment_list', via: [:get, :post]
      end
      member do
        get 'ready'
      end
    end

  end

end

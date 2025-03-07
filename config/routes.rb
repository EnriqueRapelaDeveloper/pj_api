Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"

  scope 'api' do
    namespace :v1 do
      resources :stores, param: :uuid do
        member do
          post :assign_products
          delete :unassign_products
          get :products
          get :orders
        end
      end
      resources :products, param: :uuid
      namespace :selects do
        get :product_kinds
      end
      resources :orders, param: :uuid, only: [:create, :update, :show] do
        member do
          post :pay
          post :deliver
          post :cancel
        end
      end
    end
  end
end

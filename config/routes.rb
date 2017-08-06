Rails.application.routes.draw do
  scope :api do
    resources :users, only: [:create] do
      member do
        resources :deposits, only: [:index, :create]
        resources :withdrawals, only: [:index, :create]
      end
    end
    resource :sessions, only: [:create, :show]
  end
end

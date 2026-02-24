Rails.application.routes.draw do
  devise_for :users

  root "chat_rooms#index"

  require "sidekiq/web"

  mount Sidekiq::Web => "/sidekiq"


  resources :chat_rooms, only: [:index, :show, :new, :create] do
    resources :messages, only: [:create]
  end
    
  resource :otp, only: [:create] do
    get :verify
    post :confirm
  end

  resources :payments, only: [:create] do
  collection do
    post :verify
  end
end
    
  namespace :api do
    post "hello", to: "hello#create"
  end


end

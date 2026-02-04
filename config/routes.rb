Rails.application.routes.draw do
  devise_for :users

  root "chat_rooms#index"

  require "sidekiq/web"

  authenticate :user, lambda { |u| u.admin? } do
    mount Sidekiq::Web => "/sidekiq"
  end



  resources :chat_rooms, only: [:index, :show, :new, :create] do
    resources :messages, only: [:create]
  end
    
  resource :otp, only: [:create] do
    get :verify
    post :confirm
  end
    
  namespace :api do
    post "hello", to: "hello#create"
  end


end

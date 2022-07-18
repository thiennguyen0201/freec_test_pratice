# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      namespace :admin do
        resources :users, only: [:index, :update, :destroy]
      end

      namespace :auth do
        resources :registration, only: [:create]
        resources :login, only: [:create]
      end
    end
  end
end

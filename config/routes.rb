# frozen_string_literal: true

Rails.application.routes.draw do
  resources :sellers
  resources :patterns
  devise_for :users, controllers: { sessions: 'users/sessions', passwords: 'users/passwords', registrations: 'users/registrations' }
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root "patterns#index"
end

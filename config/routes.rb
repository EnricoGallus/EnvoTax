# frozen_string_literal: true

Rails.application.routes.draw do
  resources :contracts do
    resources :contract_instances, except: [:index, :show]
  end

  resources :income_taxes
  resources :payment_statements do
    resources :payment_allocations, except: [:index]
  end
  resources :payment_adjustments
  resources :cost_types
  resources :invoices, except: [:edit, :update] do
    member do
      get :preview
      post :approve
    end
  end
  resources :time_entries, except: [:show]
  resources :expenses
  resources :clients
  resources :projects
  resource :account, only: [:edit, :update], controller: "users"

  devise_for :users, skip: [:registrations]

  resources :dashboard, only: :index do
    collection do
      get :today
      get :weekly
      get :monthly
      get :unbilled_time
      get :outstanding_invoices
    end
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  root to: "dashboard#index"
end

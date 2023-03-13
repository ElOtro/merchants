# frozen_string_literal: true

Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'

  scope 'v1', defaults: { format: :json } do
    devise_for :admins, defaults: { format: :json }, path: '',
                        path_names: { sign_in: 'auth', sign_out: 'auth', registration: 'admins' },
                        controllers: { sessions: 'v1/admins/sessions', registrations: 'v1/admins/registrations' }

    devise_for :merchants, defaults: { format: :json }, path: '',
                           path_names: { sign_in: 'merchants/auth', sign_out: 'merchants/auth' },
                           controllers: { sessions: 'v1/merchants/sessions' }
  end

  namespace :v1, defaults: { format: :json } do
    resources :dashboard, only: :index
    resources :payments, only: :create
    resources :transactions, only: :index
    resources :admins
    resources :merchants
  end

  match '*a', to: 'errors#routing', via: %i[get post]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end

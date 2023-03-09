Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'

  scope 'v1', defaults: { format: :json } do
    devise_for :users, defaults: { format: :json }, path: '',
                       path_names: { sign_in: 'auth', sign_out: 'auth', registration: 'users' },
                       controllers: { sessions: 'v1/users/sessions', registrations: 'v1/users/registrations' }
  end

  namespace :v1, defaults: { format: :json } do
    resources :dashboard, only: :index
  end

  match '*a', to: 'errors#routing', via: %i[get post]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end

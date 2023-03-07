Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  
  devise_for :users, defaults: { format: :json },
              controllers: {
                sessions: 'users/sessions',
                registrations: 'users/registrations'
              }
 

  namespace :v1, defaults: { format: :json } do
    resources :dashboard, only: :index
  end

  match '*a', :to => 'errors#routing', :via => [:get, :post]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end

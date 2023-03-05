Rails.application.routes.draw do
  
  devise_for :users, defaults: { format: :json },
              controllers: {
                sessions: 'users/sessions',
                registrations: 'users/registrations'
              }
 

  namespace :v1, defaults: { format: :json } do
    resources :dashboard, only: :index
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end

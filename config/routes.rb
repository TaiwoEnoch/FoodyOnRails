Rails.application.routes.draw do
  devise_for :users
  # get 'home/index'
  root 'home#index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  get '/public_recipes', to: 'recipes#index', as: 'public_recipes'

  # Defines the root path route ("/")
  # root "articles#index"

end

Rails.application.routes.draw do
  #resources :recipes
  devise_for :users
  # get 'home/index'
  authenticated :user do
  root 'home#index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  resources :foods, only: %i[index new create destroy]
  resources :recipes, only: %i[index show new create destroy update] do
    member do
      post 'toggle_public'
      get 'shopping_list'
    end
    resources :foods, only: [:new, :create]
    resources :recipe_foods, only: [:new, :create,  :update,  :destroy],  except: [:show]
  end
  resources :public_recipes, only: %i[index show]
  # Defines the root path route ("/")
  # root "articles#index"
  resources :inventories do
    resources :inventory_foods, only: [:new, :create, :destroy]
  end
 end

end

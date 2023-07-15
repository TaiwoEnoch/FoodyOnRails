Rails.application.routes.draw do
  devise_for :users
 
  authenticated :user do
  root 'home#index'
 
  resources :foods, only: %i[index new create destroy]
  resources :recipes, only: %i[index show new create destroy update] do
    member do
      post 'toggle_public'
    end
    resources :foods, only: [:new, :create]
    resources :recipe_foods, only: [:new]
  end
  resources :public_recipes, only: %i[index show]
  resources :general_shopping_list, only: [:index ,:show]
  resources :inventories, only: %i[index new create show destroy] do
    resources :inventory_foods, only: [:new, :create, :destroy]
  end
end
get 'shopping_list', to: 'recipes#shopping_list', as: 'shopping_list'
end

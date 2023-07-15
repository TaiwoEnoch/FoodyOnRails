Rails.application.routes.draw do
  devise_for :users

  authenticated :user do
    root 'recipes#index', as: :authenticated_root

    resources :foods, only: %i[index new create destroy]
    resources :recipes, only: %i[index show new create destroy update] do
      member do
        post 'toggle_public'
        get 'shopping_list'
      end

      resources :recipe_foods, only: %i[new create destroy]
    end

    resources :public_recipes, only: %i[index show]
    resources :general_shopping_list, only: %i[index show]
    resources :inventories, only: %i[index new create show destroy] do
      resources :inventory_foods, only: %i[new create destroy]
      get 'shopping_list', on: :member
    end
  end

  root 'home#index'
end

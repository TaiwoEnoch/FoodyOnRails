Rails.application.routes.draw do
  devise_for :users

  authenticated :user do
    root 'recipes#index', as: :authenticated_root

    resources :foods, only: %i[index new create destroy]
    resources :recipes, only: %i[index show new create destroy update] do
      member do
        patch 'toggle'
      end
      resources :recipe_foods, only: %i[new create destroy]
    end

    resources :inventories, only: %i[index new create show destroy] do
      resources :inventory_foods, only: %i[new create destroy]
    end
  end

  resources :public_recipes, only: %i[index show]
  resources :general_shopping_list, only: [:index, :show]

  root 'home#index'
  get 'shopping_list', to: 'recipes#shopping_list', as: 'shopping_list'
end

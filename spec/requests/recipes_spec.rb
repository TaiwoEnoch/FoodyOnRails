require 'rails_helper'

RSpec.describe 'Recipe', type: :request do
  before do
    @user = User.create(name: 'Test', email: 'test2@example.com', password: 'password')
    sign_in @user
  end

  describe 'GET /recipes' do
    it 'should respond with success' do
      get '/recipes'
      expect(response).to have_http_status(:success)
    end

    it 'should render correct template' do
      get '/recipes'
      expect(response).to render_template('index')
    end
  end

  describe 'GET /recipes/:id' do
    let(:recipe) do
      Recipe.create(user: @user, name: 'test recipe', preparation_time: '1 hr', cooking_time: '1.5 hrs',
                    description: 'test description', public: true)
    end

    it 'should respond with success' do
      get recipe_path(recipe)
      expect(response).to have_http_status(:success)
    end

    it 'should render correct template' do
      get recipe_path(recipe)
      expect(response).to render_template('show')
    end

    it 'should include recipe name in the response body' do
      get recipe_path(recipe)
      expect(response.body).to include('test recipe')
    end
  end

  describe 'POST /recipes' do
    it 'creates a new recipe' do
      expect do
        post '/recipes',
             params: { recipe: { name: 'New Recipe', cooking_time: 2, preparation_time: 1,
                                 description: 'New recipe description', public: true, user_id: @user.id } }
      end.to change { Recipe.count }.by(1)

      created_recipe = Recipe.last
      expect(created_recipe.name).to eq('New Recipe')
      expect(created_recipe.cooking_time).to eq 2
      expect(created_recipe.preparation_time).to eq 1
      expect(created_recipe.description).to eq('New recipe description')
      expect(created_recipe.public).to be true
      expect(created_recipe.user_id).to eq(@user.id)
    end

    it 'redirects to the created recipe' do
      post '/recipes',
           params: { recipe: { name: 'New Recipe', cooking_time: '2 hrs', preparation_time: '1 hr',
                               description: 'New recipe description', public: true, user_id: @user.id } }
      created_recipe = Recipe.last
      expect(response).to redirect_to(recipe_path(created_recipe))
    end
  end

  describe 'PATCH /recipes/:id' do
    let(:recipe) do
      Recipe.create(user_id: @user.id, name: 'test recipe', preparation_time: '1 hr', cooking_time: '1.5 hrs',
                    description: 'test description', public: true)
    end
    let(:recipe_attributes) { { name: 'Updated Recipe' } }

    it 'updates recipe visibility' do
      patch recipe_path(recipe), params: { recipe: recipe_attributes }
      expect(response).to redirect_to(recipe_path(recipe))
      recipe.reload
      expect(recipe.name).to eq('Updated Recipe')
    end
  end

  describe 'DELETE /recipes/:id' do
    let!(:recipe) do
      Recipe.create(user: @user, name: 'test recipe', preparation_time: '1 hr', cooking_time: '1.5 hrs',
                    description: 'test description', public: true)
    end

    it 'deletes a recipe' do
      expect do
        delete recipe_path(recipe)
      end.to change(Recipe, :count).by(-1)

      expect(response).to redirect_to(recipes_path)
    end
  end
end

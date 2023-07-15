class RecipesController < ApplicationController
  before_action :set_recipe, only: %i[show edit update destroy]
  before_action :authenticate_user!

  # GET /recipes or /recipes.json
  def index
    @recipes = Recipe.includes(:user).all
  end

  # GET /recipes/1 or /recipes/1.json
  def show
    @recipe = Recipe.includes(recipe_foods: :food).find(params[:id])
    @recipe_id = @recipe.id
    @inventories = Inventory.all

    render :show
    @recipe = Recipe.find(params[:id])
    @inventories = current_user.inventories
    @recipe_foods = @recipe.recipe_foods.includes(:food)
    @recipe_food = RecipeFood.new # Add this line to instantiate a new recipe_food object for the form
  end

  # GET /recipes/new
  def new
    @recipe = Recipe.new
  end

  # GET /recipes/1/edit
  def edit; end

  # POST /recipes or /recipes.json
  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.user = current_user

    respond_to do |format|
      if @recipe.save
        format.html { redirect_to recipe_url(@recipe), notice: 'Recipe was successfully created.' }
        format.json { render :show, status: :created, location: @recipe }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @recipe.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /recipes/1 or /recipes/1.json
  def update
    respond_to do |format|
      if @recipe.update(recipe_params.merge(user: current_user))
        format.html { redirect_to recipe_url(@recipe), notice: 'Recipe was successfully updated.' }
        format.json { render :show, status: :ok, location: @recipe }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @recipe.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /recipes/1 or /recipes/1.json
  def destroy
    @recipe.destroy

    respond_to do |format|
      format.html { redirect_to recipes_url, notice: 'Recipe was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def shopping_list
    @recipe_id = params[:recipe_id]
    @inventory_id = params[:inventory_id]

    @recipe = Recipe.includes(recipe_foods: :food).find(@recipe_id)
    @inventory = Inventory.find(@inventory_id)

    inventory_foods_id = @inventory.foods.pluck(:id)
    @missing_foods = @recipe.recipe_foods.reject { |food_recipe| inventory_foods_id.include?(food_recipe.food_id) }
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_recipe
    @recipe = Recipe.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def recipe_params
    params.require(:recipe).permit(:name, :cooking_time, :preparation_time, :description, :public, :user_id,
                                   recipe_foods_attributes: %i[id food_name quantity _destroy])
  end
end

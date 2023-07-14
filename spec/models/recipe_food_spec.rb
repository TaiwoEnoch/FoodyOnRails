# spec/models/recipe_food_spec.rb
require 'rails_helper'

RSpec.describe RecipeFood, type: :model do
  describe 'associations' do
    it 'belongs to recipe' do
      association = described_class.reflect_on_association(:recipe)
      expect(association.macro).to eq(:belongs_to)
    end

    it 'belongs to food' do
      association = described_class.reflect_on_association(:food)
      expect(association.macro).to eq(:belongs_to)
    end
  end

  describe 'validations' do
    it 'validates presence of quantity' do
      recipe_food = RecipeFood.new(quantity: nil)
      expect(recipe_food.valid?).to be_falsey
      expect(recipe_food.errors[:quantity]).to include("can't be blank")
    end

    it 'validates numericality of quantity' do
      recipe_food = RecipeFood.new(quantity: -1)
      expect(recipe_food.valid?).to be_falsey
      expect(recipe_food.errors[:quantity]).to include('must be greater than or equal to 0')
    end

    it 'validates presence of recipe_id' do
      recipe_food = RecipeFood.new(recipe_id: nil)
      expect(recipe_food.valid?).to be_falsey
      expect(recipe_food.errors[:recipe_id]).to include("can't be blank")
    end

    it 'validates presence of food_name' do
      recipe_food = RecipeFood.new(food_name: nil)
      expect(recipe_food.valid?).to be_falsey
      expect(recipe_food.errors[:food_name]).to include("can't be blank")
    end
  end
end

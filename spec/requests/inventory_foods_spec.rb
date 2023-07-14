require 'rails_helper'

RSpec.describe 'InventoryFoods', type: :request do
  describe 'POST :create' do
    before do
      @user = User.create(name: 'test', email: 'test2@example.com', password: 'password')
      sign_in @user
      @inventory = Inventory.create(user: @user, name: 'Inventory1',
                                    description: 'test description')
      @test_food = Food.create(name: 'test food', measurement_unit: 2, price: 10, unit_quantity: 'kgs')
    end
    it 'creates a new inventorye_food' do
      inventory_attributes = { quantity: 20, food_id: @test_food.id, quantity_unit: 'kgs' }
      post inventory_inventory_foods_path(@inventory), params: { inventory_food: inventory_attributes }

      expect(InventoryFood.quantity).to eq(20)
      expect(InventoryFood.food).to eq(@test_food)
    end
  end
end

class CreateInventoryFoods < ActiveRecord::Migration[7.0]
  def change
    create_table :inventory_foods do |t|
      t.integer :quantity
      t.references :food, null: false, foreign_key: true
      t.references :inventory, null: false, foreign_key: true
      t.string :quantity_unit

      t.timestamps
    end
  end
end

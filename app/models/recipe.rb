class Recipe < ApplicationRecord
  belongs_to :user
  has_many :recipe_foods
  has_many :foods, through: :recipe_foods

  scope :public_recipes, -> { where(public: true) }

  validates :name, presence: true
  validates :cooking_time, presence: true
  validates :preparation_time, presence: true
  validates :description, presence: true
  validates_inclusion_of :public, in: [true, false]

  def total_price
    foods.map { |f| f.price.to_i * f.recipe_foods.find_by(recipe_id: id).quantity.to_i }.sum
  end
end

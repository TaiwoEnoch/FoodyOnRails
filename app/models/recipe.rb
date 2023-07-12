class Recipe < ApplicationRecord
  belongs_to :user
  has_many :recipe_foods
  has_many :foods, through: :recipe_foods

  validates :name, presence: true
  validates :cooking_time, presence: true
  validates :preparation_time, presence: true
  validates :description, presence: true
  validates_inclusion_of :public, in: [true, false]
end

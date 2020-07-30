class Dose < ApplicationRecord
  validates :description, presence: true
  validates :cocktail, presence: true
  validates :ingredient, presence: true, uniqueness: { scope: :cocktail }


  belongs_to :cocktail
  belongs_to :ingredient
end

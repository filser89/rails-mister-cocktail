require 'open-uri'
require 'json'

Cocktail.destroy_all
Ingredient.destroy_all

# url = 'https://www.thecocktaildb.com/api/json/v1/1/list.php?i=list'
# response = open(url).read
# d = JSON.parse(response)

# d["drinks"].each do |drink|
#  i = Ingredient.create!(name: drink["strIngredient1"])
#   p "created #{i.name}"
# end

# 10.times do
#   c = Cocktail.create!(name: Faker::Sports::Football.unique.team)
#   p "Created #{c}"
#   d = Dose.create!(description: "100 ml", cocktail: c, ingredient: Ingredient.all.sample)
#   p "Created #{d} for #{c}"
# end


def createIngredient(drink, c)
  ingredients = []
  ingredients.push(drink["strIngredient1"]) unless drink["strIngredient1"].nil?
  ingredients.push(drink["strIngredient2"]) unless drink["strIngredient2"].nil?
  ingredients.push(drink["strIngredient3"]) unless drink["strIngredient3"].nil?

  ingredients.each do |ingr|
    i = Ingredient.find_or_create_by(name: ingr)
    p i
    p "Created #{i.name}"
    doses = ["1 table spoon", "50 ml", "100 ml"]
    Dose.create!(description: doses.sample, cocktail: c, ingredient: i)
  end
end

20.times do |i|
  # sleep 2
  cocktail = i + 10
  url = "https://www.thecocktaildb.com/api/json/v1/1/lookup.php?i=110#{cocktail}"
  response = open(url).read
  d = JSON.parse(response)
  p  d
  next if d["drinks"].nil?
  drink = d["drinks"][0]
  c = Cocktail.create!(name: drink["strDrink"], image: drink["strDrinkThumb"])
  p "Created cocktail #{c.name}"
  createIngredient(drink, c)

end

puts "Created #{Ingredient.count} ingredients"
puts "Created #{Cocktail.count} cocktails"
puts "Created #{Dose.count} doses"


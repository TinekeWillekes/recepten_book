class AddCookingTimeToRecipes < ActiveRecord::Migration
  def change
    add_column :recipes, :cooking_time, :integer
  end
end

class AddNumberOfPersonsToRecipes < ActiveRecord::Migration
  def change
    add_column :recipes, :number_of_persons, :integer
  end
end

class AddActiveToRecipes < ActiveRecord::Migration
  def change
    add_column :recipes, :active, :integer, :default => 1
  end
end

class AddHistoryToRecipes < ActiveRecord::Migration
  def change
    add_column :recipes, :history, :text
  end
end

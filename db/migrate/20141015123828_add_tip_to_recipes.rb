class AddTipToRecipes < ActiveRecord::Migration
  def change
    add_column :recipes, :tip, :text
  end
end

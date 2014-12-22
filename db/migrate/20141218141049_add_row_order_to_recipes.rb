class AddRowOrderToRecipes < ActiveRecord::Migration
  def change
    add_column :recipes, :row_order, :integer
  end
end

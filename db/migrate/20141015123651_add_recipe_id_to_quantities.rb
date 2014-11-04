class AddRecipeIdToQuantities < ActiveRecord::Migration
  def change
    add_column :quantities, :recipe_id, :integer
  end
end

class AddRecipeImageMetaToRecipes < ActiveRecord::Migration
  def change
    add_column :recipes, :recipe_image_meta, :text
  end
end

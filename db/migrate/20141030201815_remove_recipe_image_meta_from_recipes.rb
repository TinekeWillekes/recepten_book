class RemoveRecipeImageMetaFromRecipes < ActiveRecord::Migration
  def change
    remove_column :recipes, :recipe_image_meta, :text
  end
end

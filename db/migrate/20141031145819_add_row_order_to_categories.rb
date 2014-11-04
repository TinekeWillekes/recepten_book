class AddRowOrderToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :row_order, :integer
  end
end

class CreateQuantities < ActiveRecord::Migration
  def change
    create_table :quantities do |t|
      t.string :amount

      t.timestamps
    end
  end
end

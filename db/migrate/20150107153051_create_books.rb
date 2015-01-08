class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string :title
      t.text :foreword
      t.string :author
      t.text :blurb
      t.integer :year_of_publication

      t.timestamps
    end
  end
end

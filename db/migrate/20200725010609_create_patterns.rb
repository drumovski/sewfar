class CreatePatterns < ActiveRecord::Migration[6.0]
  def change
    create_table :patterns do |t|
      t.references :user, foreign_key: true
      t.string :name
      t.string :sizes
      t.string :fabric
      t.integer :fabric_amount
      t.integer :type
      t.integer :category
      t.float :price
      t.text :description
      t.integer :difficulty
      t.text :notions
      t.boolean :complete

      t.timestamps
    end
  end
end

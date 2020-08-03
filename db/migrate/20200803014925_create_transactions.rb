class CreateTransactions < ActiveRecord::Migration[6.0]
  def change
    create_table :transactions do |t|
      t.references :user, null: false, foreign_key: true
      t.references :pattern, null: false, foreign_key: true
      t.float :price
      t.boolean :successful

      t.timestamps
    end
  end
end

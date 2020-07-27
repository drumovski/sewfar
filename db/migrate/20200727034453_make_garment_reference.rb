class MakeGarmentReference < ActiveRecord::Migration[6.0]
  def change
    remove_column :patterns, :garment
    add_column :patterns, :garment_id, :integer, references: :garment
  end
end

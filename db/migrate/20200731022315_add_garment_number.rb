class AddGarmentNumber < ActiveRecord::Migration[6.0]
  def change
    add_column :garments, :garment_number, :integer
  end
end

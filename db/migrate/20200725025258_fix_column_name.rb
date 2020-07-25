class FixColumnName < ActiveRecord::Migration[6.0]
  def change
    rename_column :patterns, :type, :garment
  end
end

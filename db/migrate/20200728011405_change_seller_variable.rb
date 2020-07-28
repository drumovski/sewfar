class ChangeSellerVariable < ActiveRecord::Migration[6.0]
  def change
    remove_column :users, :seller
    add_column :users, :is_seller, :boolean
  end
end

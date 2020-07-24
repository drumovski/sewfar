class AddNameSellerToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :seller, :boolean
    add_column :users, :name, :string
  end
end

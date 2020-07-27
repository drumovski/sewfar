class CreateSellers < ActiveRecord::Migration[6.0]
  def change
    create_table :sellers do |t|
      t.string :business_name
      t.string :abn
      t.string :website
      t.string :facebook
      t.string :twitter
      t.string :linkedin
      t.string :instagram
      t.text :about
      t.text :address_line_1
      t.text :address_line_2
      t.string :city
      t.string :postcode
      t.string :country

      t.timestamps
    end
  end
end

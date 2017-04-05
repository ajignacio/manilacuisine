class CreateRestaurants < ActiveRecord::Migration
  def change
    create_table :restaurants do |t|
      t.references :cuisine, index: true, foreign_key: true
      t.string :name
      t.string :address
      t.string :telephone_number
      t.integer :rate

      t.timestamps null: false
    end
  end
end

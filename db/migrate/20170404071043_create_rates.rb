class CreateRates < ActiveRecord::Migration
  def change
    create_table :rates do |t|
      t.references :restaurant, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true
      t.integer :rating, default: 0

      t.timestamps null: false
    end
  end
end

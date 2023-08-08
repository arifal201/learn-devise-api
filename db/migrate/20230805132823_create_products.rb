class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.string :name
      t.integer :quantity
      t.decimal :prices, precision: 10, scale: 2

      t.timestamps
    end
  end
end

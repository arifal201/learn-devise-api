class CreateInvoiceProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :invoice_products do |t|
      t.references :product, null: false, foreign_key: true
      t.string :name
      t.decimal :quantity
      t.decimal :prices

      t.timestamps
    end
  end
end

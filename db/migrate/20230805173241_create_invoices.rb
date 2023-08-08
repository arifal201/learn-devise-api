class CreateInvoices < ActiveRecord::Migration[7.0]
  def change
    create_table :invoices do |t|
      t.references :user, null: false, foreign_key: true
      t.string :invoice_number
      t.decimal :total_prices
      t.integer :total_qty
      t.date :due_date
      t.string :item_name

      t.timestamps
    end
  end
end

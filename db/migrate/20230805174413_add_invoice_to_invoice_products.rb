class AddInvoiceToInvoiceProducts < ActiveRecord::Migration[7.0]
  def change
    add_reference :invoice_products, :invoice, null: false, foreign_key: true 
  end
end

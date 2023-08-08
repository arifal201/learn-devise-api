class InvoiceSerializer < Oj::Serializer
  attributes :id, :total_prices, :total_qty, :item_name, :invoice_number, :due_date, :user_id
  has_many :invoice_products, serializer: InvoiceProductSerializer
end
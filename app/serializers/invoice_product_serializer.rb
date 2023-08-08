class InvoiceProductSerializer < Oj::Serializer
  attributes :id, :name, :quantity, :prices, :product_id
end
class ProductSerializer < Oj::Serializer
  attributes :id, :name, :prices, :quantity
end
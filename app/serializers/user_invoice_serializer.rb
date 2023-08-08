class UserInvoiceSerializer < Oj::Serializer
  attributes :id, :email
  has_many :invoices, serializer: InvoiceSerializer
end
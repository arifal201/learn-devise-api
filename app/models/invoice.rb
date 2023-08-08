class Invoice < ApplicationRecord
  belongs_to :user
  has_many :invoice_products, dependent: :destroy

  accepts_nested_attributes_for :invoice_products, allow_destroy: true
end

require_relative 'priceable'

class InvoiceItem < ApplicationRecord
  include Priceable

  belongs_to :invoice
  belongs_to :item
  has_one :merchant, through: :item

  enum status: [:pending, :packaged, :shipped]

end

require_relative 'priceable'

class InvoiceItem < ApplicationRecord
  include Priceable

  belongs_to :invoice
  belongs_to :item

  enum status: [:pending, :packaged, :shipped]

end

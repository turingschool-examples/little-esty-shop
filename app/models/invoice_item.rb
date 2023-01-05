class InvoiceItem < ApplicationRecord
  enum status: {"pending": 0, "packaged": 1, "shipped": 2}

  belongs_to :item
  belongs_to :invoice

  # def self.unshipped_items
  #   # require 'pry'; binding.pry
  #   # invoice_items.where.not(status: :shipped)

  #   Item.joins(:invoice_items).where('invoice_items.status!=0').select(:name)
  # end
end
class InvoiceItem < ApplicationRecord
  belongs_to :invoice
  belongs_to :item

  def create
  end

  def self.unshipped_items
    where.not(status: "shipped")
  end
end

class InvoiceItem < ApplicationRecord
  enum status: ["packaged", "pending", "shipped"]

  belongs_to :invoice
  belongs_to :item

  def self.revenue
      sum('quantity * unit_price')
  end
end

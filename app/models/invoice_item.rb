class InvoiceItem < ApplicationRecord
  belongs_to :item
  belongs_to :invoice
  has_many :transactions, through: :invoices
  has_one :merchant, through: :item
  has_one :customer, through: :invoice

  enum status: {packaged: 0,
                pending: 1,
                shipped: 2}

  def revenue
    self.quantity * self.unit_price / 100.00
  end

  def self.revenue
    self.sum("(quantity * unit_price) / 100.00")
  end
end
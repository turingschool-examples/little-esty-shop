class InvoiceItem < ApplicationRecord
  belongs_to :item
  belongs_to :invoice
  has_many :customer, through: :invoice
  has_many :transactions, through: :invoice

  enum status: ["pending", "packaged", "shipped"]

  def self.invoice_total_revenue 
    pluck('SUM(quantity*unit_price)').first
  end
end

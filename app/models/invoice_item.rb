class InvoiceItem < ApplicationRecord
  belongs_to :item
  belongs_to :invoice
  has_many :customer, through: :invoice

  enum status: ["pending", "packaged", "shipped"]

  def self.invoice_total_revenue 
    # @invoice.invoice_items.invoice_total_revenue
    x= select('SUM(quantity*unit_price) as revenue_sum')
    x.first.revenue_sum
  end
end

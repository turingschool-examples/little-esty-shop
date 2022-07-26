class InvoiceItem < ApplicationRecord
  enum status: [:packaged, :pending, :shipped]

  validates_presence_of :quantity
  validates_presence_of :unit_price
  validates_presence_of :status
  validates_presence_of :created_at
  validates_presence_of :updated_at

  belongs_to :item 
  belongs_to :invoice 


  def self.incomplete_invoices_not_shipped
    # select(:invoice_id).distinct.where.not('status = ?', 2)
    select('invoices.*').distinct.joins(:invoice_items).where.not(invoice_items: {status: 2})
  end
end

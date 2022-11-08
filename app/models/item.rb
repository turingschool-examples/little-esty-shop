class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items
  has_many :invoices, through: :invoice_items
  has_many :customers, through: :invoices

  validates_presence_of :name, :description, :unit_price, :merchant_id
  validates_numericality_of :unit_price, greater_than: 0

  enum status: { disabled: 0, enabled: 1 }

  def top_whatever
    invoices
     .joins(:invoice_items)
     .where('invoices.status = 1')
    #  
    # invoices.created_at AS invoice_date, 
     .select('invoices.*, SUM(invoice_items.quantity) AS total_sold')
     .group('invoices.created_at')
  end
end
